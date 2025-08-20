;;; dock.el ---  Integration for desktop environment's taskbar/dock -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: July 16, 2025
;; Package-Version: 20250720.1954
;; Package-Revision: 8397c69d3344
;; Keywords: lisp
;; Homepage: https://github.com/hron/dock.el
;; Package-Requires: ((emacs "28.1"))
;; SPDX-License-Identifier: MIT
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Integrate desktop environment's taskbar/dock with Emacs.
;;
;;; Code:

(require 'dbus)

(defgroup dock nil
  "Integrate desktop environment's taskbar/dock with Emacs."
  :link '(url-link :tag "Website" "https://github.com/hron/dock.el")
  :link '(emacs-library-link :tag "Library Source" "dock.el")
  :group 'convenience
  :group 'environment
  :prefix "dock-")

(defcustom dock-desktop-entry "emacs"
  "The desktop file id of Emacs.

This is used when sending D-Bus messages to pinpoint the taskbar entry
for updating the properties.  Usually, this is just `emacs', but
in case Emacs is used as a dedicated window for applications like
`org-mode', with separate desktop file, you might want to set it
accordingly to match such entry on the taskbar."
  :group 'dock
  :type 'string)

;;;###autoload
(define-minor-mode dock-track-urgency-mode
  "Manage the urgent status of the Emacs Dock icon.
When active, this mode provides two key behaviors:
1. It automatically removes urgent status when an Emacs frame gains focus.
2. It prevents setting urgent status if the frame already has focus when
`dock-set-needs-attention' is called.
This provides the expected behavior for a modern GUI application."
  :global t
  :interactive nil
  :group 'dock
  (remove-function after-focus-change-function #'dock--remove-needs-attention-on-focus)
  (when dock-track-urgency-mode
    (add-function :after after-focus-change-function #'dock--remove-needs-attention-on-focus)))

(defun dock--remove-needs-attention-on-focus (&optional _ign)
  "Remove urgent status from the Emacs Dock icon on focus in."
  (when (dock--any-frame-focused-p)
    (dock-remove-needs-attention)))

;; This is just a copy of `blink-cursor--should-blink'
(defun dock--any-frame-focused-p ()
  "Determine whether we should remove urgent status from Emacs Dock icon.
Returns whether we have any focused non-TTY frame."
  (let ((frame-list (frame-list))
        (any-graphical-focused nil))
    (while frame-list
      (let ((frame (pop frame-list)))
        (when (and (display-graphic-p frame) (frame-focus-state frame))
          (setf any-graphical-focused t)
          (setf frame-list nil))))
    any-graphical-focused))

;;;###autoload
(defun dock-set-needs-attention ()
  "Request attention for the Emacs Dock icon."
  (when (or (not dock-track-urgency-mode)
            (not (dock--any-frame-focused-p)))
    (dock--send-update :urgent t)))

;;;###autoload
(defun dock-remove-needs-attention ()
  "Remove the `needs attention' state from the Emacs Dock icon."
  (dock--send-update :urgent nil))

;;;###autoload
(defun dock-set-count-badge (number)
  "Set the count badge on the Emacs Dock icon to NUMBER."
  (dock--send-update :count number :count-visible t))

;;;###autoload
(defun dock-remove-count-badge ()
  "Remove the count badge from the Emacs Dock icon."
  (dock--send-update :count-visible nil))

;;;###autoload
(defun dock-set-progress (progress)
  "Set the progress indicator on the Emacs Dock icon to PROGRESS.
PROGRESS is a number between 0 and 1."
  (dock--send-update :progress progress :progress-visible t))

;;;###autoload
(defun dock-remove-progress ()
  "Remove the progress indicator from the Emacs Dock icon."
  (dock--send-update :progress-visible nil))

(defun dock--send-update (&rest params)
  "Send D-Bus signal to Dock with update about Emacs.
Various PARAMS can be set:

 :bus              The D-Bus bus, if different from `:session'.
 :urgent           Tells the launcher to get the users attention
 :count            A number to display on the launcher icon.  You must
                   also set the `count-visible` property to true in order
                   for this to show.
 :count-visible    Determines whether the `count` is visible
 :progress         A double precision floating point number between 0 and
                   1. This will be rendered as a progress bar or similar
                   on the launcher icon.  You must also set the
                   `progress-visible` property to true in order for this
                   to show.
 :progress-visible Determines whether the `progress` is visible
 :updating         Tells the launcher that the application is being updated, to
                   inform the user."
  (let ((bus (or (plist-get params :bus) :session))
        (application-id (concat "application://" dock-desktop-entry ".desktop"))
        (dbus-arguments (apply #'dock--build-dbus-args params)))
    (dbus-send-signal
     bus
     nil
     "/"
     "com.canonical.Unity.LauncherEntry"
     "Update"
     application-id
     dbus-arguments)))

(defun dock--build-dbus-args (&rest params)
  "Convert the function arguments to arguments for `dbus-send-signal'.

PARAMS are converted to corresponding arguments `dbus-send-signal'
requires.  This is a helper for `dock--send-update', see its documentation for
arguments meaning."
  (let (args)

    (when (plist-member params :urgent)
      (let ((value (plist-get params :urgent) ))
        (push `(:dict-entry "urgent" (:variant :boolean ,value)) args)))

    (when-let (count (plist-get params :count))
      (push `(:dict-entry "count" (:variant :uint32 ,count)) args))

    (when (plist-member params :count-visible)
      (let ((value (plist-get params :count-visible) ))
        (push `(:dict-entry "count-visible" (:variant :boolean ,value)) args)))

    (when-let (progress (plist-get params :progress))
      (push `(:dict-entry "progress" (:variant :double ,progress)) args))

    (when (plist-member params :progress-visible)
      (let ((value (plist-get params :progress-visible)))
        (push `(:dict-entry "progress-visible" (:variant :boolean ,value)) args)))

    (when (plist-member params :updating)
      (let ((value (plist-get params :updating)))
        (push `(:dict-entry "updating" (:variant :boolean ,value)) args)))

    args))

(dock-track-urgency-mode +1)

(provide 'dock)
;;; dock.el ends here

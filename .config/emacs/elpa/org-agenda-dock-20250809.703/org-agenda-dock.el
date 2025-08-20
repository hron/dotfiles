;;; org-agenda-dock.el ---  Integrate org-mode with Gnome's Dock or KDE's taskbar -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: July 18, 2025
;; Package-Version: 20250809.703
;; Package-Revision: 1a0d37f471b6
;; Keywords: convenience org dock desktop
;; Homepage: https://github.com/hron/org-agenda-dock
;; Package-Requires: ((emacs "28.1") (dock "0.0.1") (org "9.0"))
;; SPDX-License-Identifier: MIT
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Integrate org-mode with Gnome's Dock or KDE's taskbar
;;
;;; Code:

(require 'dock)
(require 'org-agenda)

(defgroup org-agenda-dock nil
  "Integrate `org-mode' with Gnome's Dock or KDE's taskbar."
  :link '(url-link :tag "Website" "https://github.com/hron/org-agenda-dock")
  :link '(emacs-library-link :tag "Library Source" "org-agenda-dock.el")
  :group 'convenience
  :group 'environment
  :group 'dock
  :prefix "org-agenda-dock-")

(defun org-agenda-dock--update ()
  "Update the count badge on the Emacs icon in the dock."
  (let ((today-todos (org-agenda-dock--count-today-todos)))
    (if (> today-todos 0)
        (dock-set-count-badge today-todos)
      (dock-remove-count-badge))))

(defun org-agenda-dock--count-today-todos ()
  "Count the number of todos scheduled for today."
  (seq-reduce
   (lambda (count org-file)
     (let* ((org-agenda-skip-scheduled-if-done t)
            (org-file (concat org-directory "/" org-file))
            (today (calendar-current-date))
            (today-todos (org-agenda-get-day-entries org-file today)))
       (+ count (length today-todos))))
   org-agenda-files
   0))

(defun org-agenda-dock--update-after-save ()
  "Update the badge with number of TODOs on the Dock.
It uses variable `org-agenda-files' to detect which files should be checked."
  (let ((buffer-base-filename (file-name-nondirectory (buffer-file-name))))
    (when (seq-contains-p org-agenda-files buffer-base-filename)
      (org-agenda-dock--update))))

(defun org-agenda-dock--update-after-reschedule (_arg &optional _time)
  "Update the badge on the Dock after `org-schedule' and `org-deadline'."
  (org-agenda-dock--update))

(defvar org-agenda-dock--timer nil
  "Timer to track periodic updates of count badge.")

;;;###autoload
(define-minor-mode org-agenda-dock-mode
  "Show a badge with number of TODOs scheduled for today on the Dock."
  :global t
  :lighter nil
  (let ((commands-to-advice '(org-schedule
                              org-deadline
                              org-agenda-do-date-earlier
                              org-agenda-do-date-later)))

    (remove-hook 'org-agenda-finalize-hook #'org-agenda-dock--update)
    (remove-hook 'org-after-todo-state-change-hook #'org-agenda-dock--update)
    (remove-hook 'after-save-hook #'org-agenda-dock--update-after-save)
    (dolist (func commands-to-advice)
      (advice-remove func #'org-agenda-dock--update-after-reschedule))
    (when org-agenda-dock--timer
      (cancel-timer org-agenda-dock--timer)
      (setq org-agenda-dock--timer nil))

    (when org-agenda-dock-mode
      (add-hook 'org-agenda-finalize-hook #'org-agenda-dock--update)
      (add-hook 'org-after-todo-state-change-hook #'org-agenda-dock--update)
      (add-hook 'after-save-hook #'org-agenda-dock--update-after-save)
      (dolist (func commands-to-advice)
        (advice-add func :after #'org-agenda-dock--update-after-reschedule))
      (setq org-agenda-dock--timer (run-at-time nil (* 15 60) #'org-agenda-dock--update)))))

(provide 'org-agenda-dock)
;;; org-agenda-dock.el ends here

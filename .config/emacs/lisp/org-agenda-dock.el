;;; org-agenda-dock.el ---  Show a badge with number of todos at dock -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: July 18, 2025
;; Version: 0.0.1
;; Keywords: lisp org dock desktop
;; Homepage: https://github.com/hron/org-agenda-dock.el
;; Package-Requires: ((emacs "28.1") (dock "0.0.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Integrate org-mode with Gnome's Dock or KDE's taskbar
;;
;;; Code:

(require 'dock)

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
            (org-file (concat org-directory "/" org-file ))
            (today (calendar-current-date))
            (today-todos (org-agenda-get-day-entries org-file today)))
       (+ count (length today-todos))))
   org-agenda-files
   0))

(defun org-agenda-dock--update-after-save ()
  "Update the badge on the Dock if the current file is listed in variable `org-agenda-files'."
  (let ((buffer-base-filename (file-name-nondirectory (buffer-file-name))))
    (when (seq-contains-p org-agenda-files buffer-base-filename)
      (org-agenda-dock--update))))

(defun org-agenda-dock--update-after-reschedule (_arg &optional _time)
  "Update the badge on the Dock after `org-schedule' and `org-deadline'."
  (org-agenda-dock--update))

;;;###autoload
(define-minor-mode org-agenda-dock-mode
  "Show a badge on the Emacs icon in the Dock with the number of TODOs scheduled for today."
  :global t
  :lighter nil
  (remove-hook 'org-agenda-finalize-hook #'org-agenda-dock--update)
  (remove-hook 'org-after-todo-state-change-hook #'org-agenda-dock--update)
  (remove-hook 'after-save-hook #'org-agenda-dock--update-after-save)
  (advice-remove 'org-schedule #'org-agenda-dock--update-after-reschedule)
  (advice-remove 'org-deadline #'org-agenda-dock--update-after-reschedule)
  (advice-remove 'org-agenda-do-date-later #'org-agenda-dock--update-after-reschedule)
  (advice-remove 'org-agenda-do-date-earlier #'org-agenda-dock--update-after-reschedule)
  (when org-agenda-dock-mode
    (add-hook 'org-agenda-finalize-hook #'org-agenda-dock--update)
    (add-hook 'org-after-todo-state-change-hook #'org-agenda-dock--update)
    (add-hook 'after-save-hook #'org-agenda-dock--update-after-save)
    (advice-add 'org-schedule :after #'org-agenda-dock--update-after-reschedule)
    (advice-add 'org-deadline :after #'org-agenda-dock--update-after-reschedule)
    (advice-add 'org-agenda-do-date-earlier :after #'org-agenda-dock--update-after-reschedule)
    (advice-add 'org-agenda-do-date-later :after #'org-agenda-dock--update-after-reschedule)))

(provide 'org-agenda-dock)
;;; org-agenda-dock.el ends here

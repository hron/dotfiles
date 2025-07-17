;;; init-org.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: April 10, 2025
;; Modified: April 10, 2025
;; Version: 0.0.1
;; Keywords: tools
;; Homepage: https://github.com/hron/init-org
;; Package-Requires: ((emacs "30.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(setq org-directory "~/org")

(use-package dock
  :if (featurep 'dbus)
  :straight (dock :type git :host github :repo "hron/dock.el")
  :init
  (require 'dock)

  (defun init-org--update-todos-badge ()
    "Update count badge on the taskbar icon of org-mode."
    (let ((today-todos (init-org--count-today-todos)))
      (if (> today-todos 0)
          (dock-set-count-badge today-todos)
        (dock-remove-count-badge))))

  (defun init-org--count-today-todos ()
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

  (add-hook 'org-agenda-finalize-hook #'init-org--update-todos-badge)
  (add-hook 'org-after-todo-state-change-hook #'init-org--update-todos-badge)
  (add-hook 'after-save-hook
            (lambda ()
              (when (seq-contains-p org-agenda-files
                                    (file-name-nondirectory (buffer-file-name)))
                (init-org--update-todos-badge)))))

;;;###autoload
(defun init-org-gtd ()
  "Prepare Emacs frame to use as a GTD system."
  (interactive)
  (require 'org)
  (when (featurep 'dbus)
    (require 'dock)
    (setq dock-desktop-file "org-mode.desktop"))
  (find-file (concat org-directory "/tasks.org" ))
  (org-agenda-list))

;;;###autoload
(defun init-org-todo-convert-to-project ()
  "Convert a subheading to a project."
  (interactive)
  (save-excursion
    (org-todo "")
    (goto-char (point-at-bol))
    (if (looking-at "\\(**+\\) ")
        (replace-match "\\1 [/] ")))
  (call-interactively 'org-insert-todo-subheading))

;;;###autoload
(defun init-org-capture ()
  "Open a new frame with Org capture inbox template."
  (interactive)
  (add-hook 'org-capture-after-finalize-hook 'kill-emacs)
  (org-capture "" "i")
  (delete-other-windows))

(use-package org
  :hook ((org-mode . (lambda ()
                       (toggle-truncate-lines -1)
                       (toggle-word-wrap +1)))
         ;; `org-agenda' and `use-package' seem to be incompatible, so bind the keys the old way
         ;; https://emacs.stackexchange.com/questions/72816/un-bind-keys-for-org-agenda-in-use-package
         (org-agenda-mode . (lambda ()
                              (define-key org-agenda-mode-map (kbd "z") #'org-agenda-undo)
                              (define-key org-agenda-mode-map (kbd "C-z") #'org-agenda-undo)
                              (define-key org-agenda-mode-map (kbd "C-<return>") #'org-agenda-todo))))
  :config (progn
            (setq org-tag-alist '(("outside" . ?o)
                                  ("read" . ?r)
                                  ("games" . ?g)
                                  ("shop" . ?s)
                                  ("windows" . ?w)
                                  ("laptop" . ?l)
                                  ("meet" . ?m)
                                  ("emacs" . ?e)
                                  ("watch" . ?a)
                                  (:startgroup)
                                  ("Elena" . ?E)
                                  (:endgroup))
                  org-todo-keywords '((sequence "TODO" "DONE"))
                  org-agenda-scheduled-later-expr "-SCHEDULED>=\"<tomorrow>\"-someday-tickler/"
                  org-agenda-na-expr (concat org-agenda-scheduled-later-expr "TODO")
                  org-agenda-active-expr (concat org-agenda-scheduled-later-expr "-DONE")
                  org-agenda-custom-commands '(("n" "NA" tags-tree org-agenda-na-expr))
                  org-agenda-files '("tasks.org" "tickler.org" "inbox.org")
                  ;; org-refile-use-outline-path t
                  org-refile-targets
                  '((nil :maxlevel . 3)
                    (org-agenda-files :maxlevel . 1)
                    (("someday.org") :maxlevel . 1))
                  ;; Without this, completers like ivy/helm are only given the first level of
                  ;; each outline candidates. i.e. all the candidates under the "Tasks" heading
                  ;; are just "Tasks/". This is unhelpful. We want the full path to each refile
                  ;; target! e.g. FILE/Tasks/heading/subheading
                  org-refile-use-outline-path 'file
                  org-outline-path-complete-in-steps nil
                  org-archive-location (concat "archive/" (format-time-string "%Y") ".org::")
                  org-archive-default-command 'org-archive-subtree
                  org-agenda-start-on-weekday 1
                  calendar-week-start-day 1
                  org-capture-templates
                  '(("i" "Todo" entry (file "~/org/inbox.org")
                     "* TODO %?\n:PROPERTIES:\n:Added: %U\n:END:\n%i\n%a"))))

  :bind (("C-c n a" . #'org-agenda)
         :map org-mode-map
         ("S-<return>" . org-insert-heading-after-current)
         ("S-M-<return>" . org-insert-todo-heading-respect-content)
         ("S-C-<up>" . org-metaup)
         ("S-C-<down>" . org-metadown)
         ("C-c C-e" . init-org-todo-convert-to-project)
         ("C-<return>" . org-todo)
         ("S-<return>" . org-insert-heading)
         ("C-S-<left>" . nil)
         ("C-S-<right>" . nil)
         ("S-<left>" . nil)
         ("S-<right>" . nil)
         ("C-S-<up>" . nil)
         ("C-S-<down>" . nil)
         ("S-<up>" . nil)
         ("S-<down>" . nil)
         ("C-j" . nil)
         ("M-S-<up>" . org-move-subtree-up)
         ("M-S-<down>" . org-move-subtree-down)
         ("M-<left>" . nil)
         ("M-<right>" . nil)
         ("C-c y" . yank-media)
         ("M-b" . #'org-insert-structure-template))
  :custom
  (org-provide-todo-statistics 'all-headlines)
  (org-insert-heading-respect-content t)
  (org-adapt-indentation t))

(use-package org-modern
  :custom
  (org-modern-star 'star)
  (org-modern-hide-stars " ")
  (org-modern-timestamp nil)
  (org-modern-progress nil)
  (org-modern-todo nil)
  :init
  (global-org-modern-mode))

(use-package org-roam
  :custom
  (org-roam-directory (file-truename (concat org-directory "/roam/")))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(provide 'init-org)
;;; init-org.el ends here

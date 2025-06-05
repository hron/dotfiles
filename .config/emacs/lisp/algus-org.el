;;; algus-org.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: April 10, 2025
;; Modified: April 10, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/hron/algus-org
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

;;;###autoload
(defun aleksei/org-gtd ()
  "Prepare Emacs frame to use as a GTD system."
  (interactive)
  (require 'org)
  (find-file (concat org-directory "/tasks.org" ))
  (org-agenda-list))

;;;###autoload
(defun algus/org-todo-convert-to-project ()
  "Convert a subheading to a project."
  (interactive)
  (save-excursion
    (org-todo "")
    (goto-char (point-at-bol))
    (if (looking-at "\\(**+\\) ")
        (replace-match "\\1 [/] ")))
  (call-interactively 'org-insert-todo-subheading))

;;;###autoload
(defun aleksei/org-capture ()
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
                  org-refile-targets '((org-agenda-files :maxlevel . 2) (("someday.org") :maxlevel . 1))
                  org-archive-location (concat "archive/" (format-time-string "%Y") ".org::")
                  org-archive-default-command 'org-archive-subtree
                  org-agenda-start-on-weekday 1
                  calendar-week-start-day 1
                  org-capture-templates
                  '(("i" "Todo" entry (file "~/org/inbox.org")
                     "* TODO %?\n:PROPERTIES:\n:Added: %U\n:END:\n%i\n%a"))))

  :bind (:map org-mode-map
              ("S-<return>" . org-insert-heading-after-current)
              ("S-M-<return>" . org-insert-todo-heading-respect-content)
              ("S-C-<up>" . org-metaup)
              ("S-C-<down>" . org-metadown)
              ("C-c C-e" . algus/org-todo-convert-to-project)
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
              ("M-S-<up>" . org-move-subtree-up)
              ("M-S-<down>" . org-move-subtree-down)
              ("M-<left>" . nil)
              ("M-<right>" . nil)
              ("C-c y" . yank-media))
  :custom (org-provide-todo-statistics 'all-headlines))

(provide 'algus-org)
;;; algus-org.el ends here

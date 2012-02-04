;;; emacs-rc-org.el --- Org-mode customization.

;; Copyright (C) 2009  Aleksei Gusev

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(setq org-replace-disputed-keys t)

(require 'org)

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-hide-leading-stars t)

(add-hook 'message-mode-hook 'turn-on-orgstruct)
(add-hook 'message-mode-hook 'turn-on-orgtbl)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(defun org-todo-convert-to-project ()
  (interactive)
  (save-excursion
    (org-todo "")
    (if (looking-at "\\(**+\\) ")
	(replace-match "\\1 [%] ")))
  ;; (org-show-entry)
  ;; (org-forward-sentence)
  ;; (newline)
  ;; (goto-char (point-at-bol))
  ;; (call-interactively 'org-insert-todo-subheading)
  ;; (call-interactively 'org-do-demote)
  (goto-char (point-at-eol)))

(add-hook 'org-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-c p") 'org-todo-convert-to-project)))
;; You can insert and follow links that have Org syntax not only in Org, but in
;; any Emacs buffer. For this, you should create two global commands, like this
;; (please select suitable global keys yourself):
(global-set-key "\C-cL" 'org-insert-link-global)
(global-set-key "\C-cO" 'org-open-at-point-global)

;; The most basic logging is to keep track of _when_ a certain TODO item
;; was finished.  This is achieved with(1).
;;
;; [[info:org:Closing%20items][info:org:Closing items]]
(setq org-log-done 'time)

(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/tasks.org.gpg"))

(add-hook 'org-mode-hook '(lambda ()
			    (make-variable-buffer-local 'electric-indent-chars)
			    (setq electric-indent-chars '())))

(add-hook 'org-mode-hook '(lambda ()
			    (local-set-key (kbd "C-M-<return>")
					   'org-insert-todo-heading)))

;; (require 'org-cua-dwim)
;; (add-hook 'org-mode-hook 'org-cua-dwim-turn-on-org-cua-mode-partial-support)

;; This allows [/] and [%] to count all children
(setq org-provide-todo-statistics 'all-headlines)
(add-hook 'org-insert-heading-hook 'org-update-parent-todo-statistics)

(setq org-tag-alist '((:startgroup . nil)
		      ("BoutiqueAir" . ?b)
		      ("FailsafePayments" . ?f)
		      (:endgroup . nil)
		      ("outside" . ?o)
		      ("read" . ?r)))

(setq org-capture-templates
      '("i" "Todo" entry (file+headline "~/org/tasks.org.gpg" "Inbox")
	"* TODO %?\n  :PROPERTIES:\n  :Added: %U\n  :END:\n  %i\n  %a"))

(add-hook 'org-capture-after-finalize-hook 'delete-frame)

(defun org-capture-system-wide ()
  "System-wide variant of org-capture."
  (interactive)
  (org-capture :keys "i")
  (delete-other-windows))

(setq org-deadline-warning-days 7)


(setq
 org-agenda-files (mapcar '(lambda (filename) (concat org-directory filename))
			  '("tasks.org.gpg"))
 org-agenda-ndays 7
 org-agenda-repeating-timestamp-show-all nil
 org-agenda-restore-windows-after-quit t
 org-agenda-show-all-dates t
 org-agenda-skip-deadline-if-done t
 org-agenda-skip-scheduled-if-done t
 org-agenda-sorting-strategy '((agenda time-up priority-down tag-up) (todo tag-up))
 org-agenda-start-on-weekday nil
 org-agenda-tags-todo-honor-ignore-options t
 org-agenda-todo-ignore-scheduled 'future
 org-agenda-todo-ignore-deadlines 'future)

(setq org-agenda-na-expression "-SCHEDULED>\"<today>\"-DEADLINE>\"<today>\"-someday/-DONE")
(setq org-agenda-custom-commands
      '(("h" "Home"
	 tags-tree (concat "-BoutiqueAir-FailsafePayments-read-outside" org-agenda-na-expression))

	("o" "Outside"
	 tags-tree (concat "outside" org-agenda-na-expression))

	("r" "Read"
	 tags-tree (concat "read" org-agenda-na-expression))

	("b" "BoutiqueAir"
	 tags-tree (concat "BoutiqueAir" org-agenda-na-expression))

	("f" "FailsafePayments"
	 tags-tree (concat "FailsafePayments" org-agenda-na-expression))))


(defun org-cmp-todo-always-first (a b)
  "Compare the todo states of strings A and B. TODO keyword always first."
  (let* ((ta (or (get-text-property 1 'todo-state a) ""))
	 (tb (or (get-text-property 1 'todo-state b) "")))
    (message "%s" ta)
    (message "%s" tb)
    (cond ((and (string= ta "TODO") (not (string= tb "TODO"))) -1)
	  ((and (not (string= ta "TODO")) (string= tb "TODO")) +1)
	  (t nil))))
(setq org-agenda-cmp-user-defined 'org-cmp-todo-always-first)

(setq org-refile-targets (quote (("tasks.org.gpg" :maxlevel . 1))))
(setq org-time-stamp-rounding-minutes '(0 5))

(setq org-clock-persist t)

(setq org-mobile-directory "/media/AEA9-05F6/tmp/mobile-org")

(setq org-feed-alist
      '(("Readability"
	 "http://www.readability.com/aleksei/latest/feed"
	 "~/org/tasks.org.gpg" "Readability"
	 :guid-permalink t)
	("Boutiqueair"
	 "https://hmsinc.unfuddle.com/ticket_reports/4/generate.rss?aak=blah&pak=blah"
	 "~/org/tasks.org.gpg" "HMS Inc.")))


(provide 'emacs-rc-org)
;;; emacs-rc-org.el ends here

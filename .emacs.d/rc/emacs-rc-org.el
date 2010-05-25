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

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-hide-leading-stars t)

(add-hook 'message-mode-hook 'turn-on-orgstruct)
(add-hook 'message-mode-hook 'turn-on-orgtbl)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

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

;; [[info:org:Setting%20up%20Remember][info:org:Setting up Remember]]
(org-remember-insinuate)
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/journal.org"))
(define-key global-map "\C-cR" 'org-remember)

(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(setq org-remember-templates
     '(("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/newgtd.org" "Задачи"))
     )

(setq org-deadline-warning-days 7)

(setq
 org-agenda-files (mapcar '(lambda (filename) (concat org-directory filename))
			  '("birthday.org" "newgtd.org"))
 org-agenda-ndays 7
 org-agenda-repeating-timestamp-show-all nil
 org-agenda-restore-windows-after-quit t
 org-agenda-show-all-dates t
 org-agenda-skip-deadline-if-done t
 org-agenda-skip-scheduled-if-done t
 org-agenda-sorting-strategy '((agenda time-up priority-down tag-up) (todo tag-up))
 org-agenda-start-on-weekday nil
 org-agenda-todo-ignore-deadlines t
 org-agenda-todo-ignore-scheduled t
 org-agenda-todo-ignore-with-date t

 org-agenda-custom-commands
 '(
   ("P" "Projects"
    ((tags "PROJECT")))

   ("H" "Office and Home Lists"
    ((agenda)
     (tags-todo "OFFICE")
     (tags-todo "HOME")
     (tags-todo "COMPUTER")
     (tags-todo "DVD")
     (tags-todo "READING")))

   ("D" "Daily Action List"
    ((agenda
      ""
      ((org-agenda-ndays 1)
       (org-agenda-sorting-strategy
	(quote ((agenda time-up priority-down tag-up) )))
       (org-deadline-warning-days 0)))))
   ))

(setq org-refile-targets (quote (("newgtd.org" :maxlevel . 1) ("someday.org" :level . 2))))
(setq org-time-stamp-rounding-minutes '(0 5))

(defun gtd ()
  (interactive)
  (find-file (concat org-directory "newgtd.org")))

(global-set-key (kbd "C-c G") 'gtd)

(provide 'emacs-rc-org)
;;; emacs-rc-org.el ends here

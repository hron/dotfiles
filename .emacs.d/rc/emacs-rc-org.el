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

(require 'org-habit)
(setq org-habit-graph-column 70)

(add-hook 'message-mode-hook 'turn-on-orgstruct)
(add-hook 'message-mode-hook 'turn-on-orgtbl)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(defun org-todo-convert-to-project ()
  (interactive)
  (save-excursion
    (org-todo "")
    (goto-char (point-at-bol))
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
(setq org-default-notes-file (concat org-directory "/tasks.org"))

(add-hook 'org-mode-hook '(lambda ()
			    (make-variable-buffer-local 'electric-indent-chars)
			    (setq electric-indent-chars '())))

(add-hook 'org-mode-hook '(lambda ()
			    (local-set-key (kbd "C-M-<return>")
					   'org-insert-todo-heading)))


(defun soft-wrap-lines ()
  "Make lines wrap at window edge and on word boundary,
in current buffer."
  (interactive)
  (setq truncate-lines nil)
  (setq word-wrap t))

(add-hook 'org-mode-hook 'soft-wrap-lines) ; make org-mode wrap long lines

;; (require 'org-cua-dwim)
;; (add-hook 'org-mode-hook 'org-cua-dwim-turn-on-org-cua-mode-partial-support)

;; This allows [/] and [%] to count all children
(setq org-provide-todo-statistics 'all-headlines)
(add-hook 'org-insert-heading-hook 'org-update-parent-todo-statistics)

(setq org-tag-alist '((:startgroup . nil)
		      ("2combinators" . ?2)
		      ("BoutiqueAir" . ?b)
		      ("FailsafePayments" . ?f)
		      (:endgroup . nil)
		      ("outside" . ?o)
		      ("read" . ?r)
		      ("relax" . ?x)
		      ("@Minsk" . ?M)
		      ("@Smorgon" . ?S)))

(setq org-capture-templates
      '(("i" "Todo" entry (file+headline "~/org/tasks.org" "Inbox")
	 "* %?\n  :PROPERTIES:\n  :Added: %U\n  :END:\n  %i\n  %a")))

(add-hook 'org-capture-after-finalize-hook 'delete-frame)

(defun org-capture-system-wide ()
  "System-wide variant of org-capture."
  (interactive)
  (org-capture :keys "i")
  (delete-other-windows))

(setq org-deadline-warning-days 7)


(setq
 org-agenda-files (mapcar '(lambda (filename) (concat org-directory filename))
			  '("tasks.org"))
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

;; if you want Enter key to open links, add this
(setq org-return-follows-link t)

(setq
 org-agenda-scheduled-later-expr "-SCHEDULED>=\"<tomorrow>\"-DEADLINE>=\"<tomorrow>\"-someday/"
 org-agenda-na-expr (concat org-agenda-scheduled-later-expr "TODO")
 org-agenda-active-expr (concat org-agenda-scheduled-later-expr "-DONE"))

(setq org-agenda-custom-commands
      '(("h" "Home"
	 tags-tree (concat "-2combinators-BoutiqueAir-FailsafePayments-relax-read-outside-@Minsk-@Smorgon" org-agenda-active-expr))
	("H" "Home (Next Actions)"
	 tags-tree (concat "-2combinators-BoutiqueAir-FailsafePayments-relax-read-outside-@Minsk-@Smorgon" org-agenda-na-expr))

	("b" "BoutiqueAir"
	 tags-tree (concat "BoutiqueAir" org-agenda-active-expr))
	("B" "BoutiqueAir (Next Actions)"
	 tags-tree (concat "BoutiqueAir" org-agenda-na-expr))

	("2" "2combinators"
	 tags-tree (concat "2combinators" org-agenda-active-expr))
	("@" "2combinators (Next Actions)"
	 tags-tree (concat "2combinators" org-agenda-na-expr))

	("f" "FailsafePayments"
	 tags-tree (concat "FailsafePayments" org-agenda-active-expr))
	("F" "FailsafePayments (Next Actions)"
	 tags-tree (concat "FailsafePayments" org-agenda-na-expr))

	("o" "Outside" tags-todo "outside-someday")
	("x" "Relax" tags-todo "relax-someday")
	("r" "Read" tags-todo "read-someday")
	("S" "Smorgon" tags-todo "@Smorgon-someday")
	("M" "Minsk" tags-todo "@Minsk-someday")
	))

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

(setq org-refile-targets (quote (("tasks.org" :maxlevel . 2))))
(setq org-time-stamp-rounding-minutes '(0 5))

(setq org-clock-persist t)
(setq org-clock-into-drawer t)

(setq org-mobile-directory (concat org-directory "mobileorg"))

;; (setq org-archive-default-command 'org-archive-to-archive-sibling)
(setq org-archive-default-command 'org-archive-subtree)

(defun org-feed-springpad-formatter (entry)
  "This function basically just removes <![CDATA[]]> from springpad notes RSS."
  (let ((template "\n* %h \n  %U\n  %a\n"))
	(let (dlines fmt tmp indent time name
		     v-h v-t v-T v-u v-U v-a)
	  (setq dlines (org-split-string (or (plist-get entry :description) "???")
					 "\n")
		v-h (or (plist-get entry :title) (car dlines) "???")
		time (or (if (plist-get entry :pubDate)
			     (org-read-date t t (plist-get entry :pubDate)))
			 (current-time))
		v-t (format-time-string (org-time-stamp-format nil nil) time)
		v-T (format-time-string (org-time-stamp-format t   nil) time)
		v-u (format-time-string (org-time-stamp-format nil t)   time)
		v-U (format-time-string (org-time-stamp-format t   t)   time)
		v-a (if (setq tmp (or (and (plist-get entry :guid-permalink)
					   (plist-get entry :guid))
				      (plist-get entry :link)))
			(concat "[[" tmp "]]\n")
		      ""))
	  ;; This is actually my code
	  (setq v-h (if (string-match "<!\\[CDATA\\[\\(.*\\)\\]\\]>" v-h)
			(replace-match "\\1" nil nil v-h)))
	  ;; end
	  (with-temp-buffer
	    (insert template)
	    (goto-char (point-min))
	    (while (re-search-forward "%\\([a-zA-Z]+\\)" nil t)
	      (setq name (match-string 1))
	      (cond
	       ((member name '("h" "t" "T" "u" "U" "a"))
		(replace-match (symbol-value (intern (concat "v-" name))) t t))
	       ((setq tmp (plist-get entry (intern (concat ":" name))))
		(save-excursion
		  (save-match-data
		    (beginning-of-line 1)
		    (when (looking-at (concat "^\\([ \t]*\\)%" name "[ \t]*$"))
		      (setq tmp (org-feed-make-indented-block
				 tmp (org-get-indentation))))))
		(replace-match tmp t t))))
	    (decode-coding-string
	     (buffer-string) (detect-coding-region (point-min) (point-max) t))))))

(setq org-feed-alist
      '(("Readability"
	 "http://www.readability.com/aleksei/latest/feed"
	 "~/org/tasks.org" "Inbox"
	 :template "\n* %h :read:\n  %U\n  %a\n"
	 :drawer "READABILITY")
	("Springpad"
	 "http://springpad.com/api/users/aleksei/blocks/mystuff?type=task&format=rss&key=3umhkt67iqpa4b"
	 "~/org/tasks.org" "Inbox"
	 :formatter org-feed-springpad-formatter
	 :drawer "SPRINGPAD")
	("Boutiqueair"
	 "https://hmsinc.unfuddle.com/ticket_reports/4/generate.rss?aak=blah&pak=blah"
	 "~/org/tasks.org" "Inbox"
	 :template "\n* %h :BoutiqueAir:\n  %U\n  %a\n"
	 :drawer "HMS")))


(defun aleksei-org-feed-update-all-and-mobile-pull ()
  "org-feed-update-all, then org-mobile-pull"
  (interactive)
  (org-feed-update-all)
  (org-mobile-pull)
  (org-mobile-push))

(define-key org-mode-map "\C-c\C-xg" 'aleksei-org-feed-update-all-and-mobile-pull)

(defun aleksei-gtd ()
  "Prepare emacs frame to use as a GTD system."
  (interactive)
  (find-file "~/org/tasks.org")
  (let ((tasks-icon "/usr/share/icons/default.kde4/256x256/apps/planner.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks")))

(defun aleksei-gtd-capture ()
  (interactive)
  (let ((tasks-icon "/usr/share/icons/default.kde4/256x256/apps/korgac.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks"))
  (org-capture-system-wide))

(defun aleksei-org-clock-time-to-float (time)
  (let ((re "\\([0-9]+\\):\\([0-9]+\\)"))
    (if (string-match re time)
	(+ (string-to-number (match-string 1 time))
	   (/ (string-to-number (match-string 2 time)) 60.0)))))

(defun aleksei-org-clocktable-insert-row (&rest cells)
  (insert-before-markers
   (concat "|"
	   (mapconcat '(lambda (x) x) cells "|")
	   "|\n")))

(defun aleksei-org-clocktable-clean-up-headline (headline)
  (let ((re "^\\(\\[[0-9]*%\\]\\|TODO\\|DONE\\)[[:space:]]*\\(.*\\)$"))
    (when (string-match re headline)
      (match-string 2 headline))
    ))

(defun aleksei-org-clocktable-write-smart-systems (ipos tables params)
  (let ((header (plist-get  params :header))
	(multifile (plist-get params :multifile)))
    (unless header (error "You must pass :header option"))

    ;; Now we need to output this tsuff
    (goto-char ipos)

    ;; Insert the text *before* the actual table
    (insert-before-markers header)

    (aleksei-org-clocktable-insert-row
     "№"
     "Наименование"
     "Количество затраченных часов"
     "Стоимость одного часа (руб.) (без НДС)"
     "Стоимость (руб.) (без НДС)")
    (insert-before-markers "|-\n")

    ;; Compute the total time
    (setq total-time (apply '+ (mapcar 'cadr tables)))

    ;; Now iterate over the tables and insert the data
    ;; but only if any time has been collected
    (when (and total-time (> total-time 0))

      (setq nentry 0)
      (while (setq tbl (pop tables))
	;; now tbl is the table resulting from one file.

	;; Get the list of node entries and iterate over it
	(setq entries (nth 2 tbl))
	(while (setq entry (pop entries))
	  (setq level (car entry)
		headline (nth 1 entry))

	  (when (= level 2)
	    (setq nentry (1+ nentry))
	    (aleksei-org-clocktable-insert-row
	     (number-to-string nentry)
	     (aleksei-org-clocktable-clean-up-headline headline)
	     (format "%.2f"
	      (aleksei-org-clock-time-to-float
	       (org-minutes-to-hh:mm-string (nth 3 entry))))

	     ""
	     "")
	    )
	  )
	)

      (insert-before-markers "|-\n")
      (aleksei-org-clocktable-insert-row
       ""
       "Итого:"
       ""
       "")

      (if (setq formula (plist-get params :formula))
	  (cond
	   ((eq formula '%)
	    ;; compute the column where the % numbers need to go
	    (setq pcol (+ 2
			  (if multifile 1 0)
			  (if level-p 1 0)
			  (if timestamp 1 0)
			  (min maxlevel (or ntcol 100))))
	    ;; compute the column where the total time is
	    (setq tcol (+ 2
			  (if multifile 1 0)
			  (if level-p 1 0)
			  (if timestamp 1 0)))
	    (insert
	     (format
	      "\n#+TBLFM: $%d='(org-clock-time%% @%d$%d $%d..$%d);%%.1f"
	      pcol            ; the column where the % numbers should go
	      (if (and narrow (not narrow-cut-p)) 3 2) ; row of the total time
	      tcol            ; column of the total time
	      tcol (1- pcol)  ; range of columns where times can be found
	      ))
	    (setq recalc t))
	   ((stringp formula)
	    (insert "\n#+TBLFM: " formula)
	    (setq recalc t))
	   (t (error "invalid formula in clocktable")))
	;; Should we rescue an old formula?
	(when (stringp (setq content (plist-get params :content)))
	  (when (string-match "^\\([ \t]*#\\+TBLFM:.*\\)" content)
	    (setq recalc t)
	    (insert "\n" (match-string 1 (plist-get params :content)))
	    (beginning-of-line 0))))

      ;; Back to beginning, align the table, recalculate if necessary
      (goto-char ipos)
      (skip-chars-forward "^|")
      (org-table-align)

      ;; I do not why, but the last part of formula does not have access to
      ;; money column on the first calculation.
      (org-table-recalculate 'all)
      (org-table-recalculate 'all)
)))

(provide 'emacs-rc-org)
;;; emacs-rc-org.el ends here

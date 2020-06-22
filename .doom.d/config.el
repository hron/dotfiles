;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aleksei Gusev"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(cua-mode)

(use-package! smartparens
  :config
   (custom-set-variables
   '(sp-override-key-bindings
     '(("C-<right>" . nil)
       ("C-<left>" . nil)))))

(defun gusev/org-gtd ()
  "Prepare emacs frame to use as a GTD system."
  (interactive)
  (dolist (f org-agenda-files)
    (find-file (concat org-directory "/" f)))
  (switch-to-buffer "tasks.org")
  (let ((tasks-icon "/usr/share/icons/Yaru/256x256/apps/org.gnome.Todo.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks")))

(defun gusev/org-capture-system-wide ()
  "System-wide variant of org-capture."
  (interactive)
  (org-capture :keys "i")
  (delete-other-windows))

(defun gusev/org-gtd-capture ()
  (interactive)
  (let ((tasks-icon "/usr/share/icons/Yaru/256x256/apps/org.gnome.Todo.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks"))
  (gusev/org-capture-system-wide))

(use-package! org
  :config (progn
           (add-hook 'org-capture-after-finalize-hook 'delete-frame)
           (add-hook 'org-mode-hook '(lambda ()
                                       (toggle-truncate-lines -1)
                                       (toggle-word-wrap +1)))
           ;; (add-hook 'after-save-hook '(lambda ()
           ;;                               (when (eq major-mode 'org-mode)
           ;;                                 (org-caldav-sync)
           ;;                                 (org-caldav-sync))))
           (setq org-tag-alist '(("outside" . ?o)
                                 ("read" . ?r)
                                 ("games" . ?g)
                                 ("shop" . ?s)
                                 ("office" . ?e)
                                 ("thor-linux" . ?t)
                                 ("thor-windows" . ?w)
                                 ("thinkpad" . ?x)
                                 (:startgroup)
                                 ("Elena" . ?E)
                                 (:endgroup)
                                 )

                 org-todo-keywords
                       '((sequence
                          "TODO"
                          "DONE"))
                 org-agenda-scheduled-later-expr "-SCHEDULED>=\"<tomorrow>\"-someday-tickler/"
                 org-agenda-na-expr (concat org-agenda-scheduled-later-expr "TODO")
                 org-agenda-active-expr (concat org-agenda-scheduled-later-expr "-DONE")
                 org-agenda-custom-commands
                 '(("n" "NA" tags-tree org-agenda-na-expr))
                 org-agenda-files '("tasks.org" "f-secure.org" "tickler.org" "inbox.org")
                 org-refile-targets '((org-agenda-files :maxlevel . 2) (("someday.org") :maxlevel . 1))
                 org-archive-location (concat "archive/" (format-time-string "%Y") ".org::")
                 org-archive-default-command 'org-archive-subtree
                 org-capture-templates
                 '(("i" "Todo" entry (file "~/org/inbox.org")
                    "* %?\n  :PROPERTIES:\n  :Added: %U\n  :END:\n  %i\n  %a"))
                 org-agenda-start-on-weekday 1
                 calendar-week-start-day 1
                 )

           (defun gusev/org-todo-convert-to-project ()
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
           ))

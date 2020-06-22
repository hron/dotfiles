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
  (require 'org)
  (dolist (f org-agenda-files)
    (find-file (concat org-directory "/" f)))
  (switch-to-buffer "tasks.org")
  (let ((tasks-icon "/usr/share/icons/Yaru/256x256/apps/org.gnome.Todo.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks")))

(defun gusev/org-capture-system-wide ()
  "System-wide variant of org-capture."
  (interactive)
  (require 'org)
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
           )
  :bind (:map org-mode-map
              ("S-<return>" . org-insert-heading-after-current)
              ("S-M-<return>" . org-insert-todo-heading-respect-content)
              ("S-M-<up>" . org-move-subtree-up)
              ("S-M-<down>" . org-move-subtree-down)
              ("C-c o" . gusev/org-todo-convert-to-project)
              ("C-c C-x g" . org-caldav-sync)
              ("C-c b" . org-switchb)
              ("M-<return>" . nil))
  )

(use-package! org-agenda
  :bind* (:map org-agenda-mode-map
              ("z" . org-agenda-undo)))

(global-set-key (kbd "M-<down>") 'other-window)
(global-unset-key (kbd "C-x O"))
(global-set-key (kbd "M-<up>") (lambda () (interactive) (other-window -1)))

(global-set-key (kbd "<escape>") 'keyboard-quit)

(use-package! helm
  :init
  (setq helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match    t
        helm-M-x-fuzzy-match      t)
  ;; (when (executable-find "ack-grep")
  ;;   (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
  ;;         helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
  ;; (when (executable-find "ag")
  ;;   (setq helm-grep-default-command "ag --nocolor --nogroup %p %f"
  ;;         helm-grep-default-recurse-command "ag --nocolor --nogroup %p %f"))
  :config
  (require 'subr-x)
  (defvar helm-source-emacs-process
    (helm-build-sync-source "Emacs Process"
      :init (lambda ()
              (let (tabulated-list-use-header-line)
                (list-processes--refresh)))
      :candidates (lambda () (mapcar
                              (lambda (process)
                                (concat (process-name process)
                                        " ["
                                        (string-join (process-command process) " ")
                                        "] "))
                              (process-list)))
      :persistent-action (lambda (elm)
                           (delete-process (get-process elm))
                           (helm-delete-current-selection))
      :persistent-help "Kill Process"
      :action (helm-make-actions "Kill Process"
                                 (lambda (_elm)
                                   (cl-loop for p in (helm-marked-candidates)
                                            do (delete-process (get-process p)))))))
  :bind (("C-e" . helm-mini)
         ("C-<f2>" . helm-list-emacs-process)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action) ; rebind tab to run persistent action
         ("C-i" . helm-execute-persistent-action) ; make TAB works in terminal
         ("C-a" . helm-select-action) ; list actions using C-a
         ("C-z" . undo-tree-undo)
         ;; :map helm-moccur-mode-map
         ;; ("RET" . helm-moccur-mode-goto-line-ow)
         ;;:map helm-find-files-map
         ;;("C-z" . undo-tree-undo)
         ))

(use-package! helm-files
  :config
  (unbind-key "C-<backspace>" helm-find-files-map)
  (unbind-key "C-<backspace>" helm-read-file-map)
  :bind (:map helm-find-files-map
         ("C-z" . undo-tree-undo)))

(use-package! expand-region
  :init
  (global-set-key (kbd "C-h") 'er/expand-region)
  (global-set-key (kbd "C-S-h") (lambda () (interactive) (er/expand-region -1))))

(use-package! mwim
  :config
  (global-set-key (kbd "<home>") 'mwim-beginning-of-code-or-line))

(global-set-key (kbd "C-M-l") 'indent-region)

(global-set-key (kbd "C-s") (lambda () (interactive) (save-some-buffers +1)))

(setq search-exit-option 'edit)
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "S-<return>") 'isearch-repeat-backward)
(define-key isearch-mode-map [return] 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "<escape>") 'isearch-exit)
(define-key isearch-mode-map (kbd "C-v") 'isearch-yank-kill)
(define-key minibuffer-local-isearch-map (kbd "<escape>") 'exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-f") 'isearch-forward-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-r") 'isearch-backward-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-v") 'isearch-yank-kill)
;; (remove-hook 'isearch-mode-hook 'isearch-yank-kill)

(global-set-key (kbd "C-M-<down>") 'next-error)
(global-set-key (kbd "C-M-<up>") (lambda () (interactive) (next-error -1)))

(setq select-enable-clipboard t)
(setq select-active-regions nil)

(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "C-/") 'comment-dwim)))

(use-package! undo-tree
  :bind (:map undo-tree-map
              ("C-/" . nil)
              ("C-S-z" . undo-tree-redo)))

(use-package! company
  :bind (:map company-mode-map
              ("<escape>" . company-abort)))

(global-set-key [f6] 'toggle-truncate-lines)
(use-package! winner
  :init
  (global-set-key [f2] 'winner-undo)
  (global-set-key [f3] 'winner-redo))

(global-set-key (kbd "C-j") '(lambda () (interactive) (next-line) (join-line)))
(global-set-key (kbd "C-S-j") '(lambda () (interactive) (next-line) (join-line)))
(global-set-key (kbd "C-d") 'spacemacs/duplicate-line-or-region)

(global-set-key (kbd "C-w") 'kill-this-buffer)

(use-package! comint
  :bind (:map comint-mode-map
              ("C-d" . comint-delchar-or-maybe-eof)
              ("C-c" . nil)))

(use-package! python-mode
  :bind (:map python-mode-map
             ("M-<right>" . python-indent-shift-right)
             ("M-<left>" . python-indent-shift-left)))

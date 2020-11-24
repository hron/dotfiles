;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aleksei Gusev"
      user-mail-address "aleksei.gusev@gmail.com")

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
(setq doom-font "JetBrains Mono Medium-11")

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
         ("C-c C-e" . gusev/org-todo-convert-to-project)
         ("C-c b" . org-switchb)
         ("C-S-<left>" . nil)
         ("C-S-<right>" . nil)
         ("S-<left>" . nil)
         ("S-<right>" . nil)
         ("C-S-<up>" . nil)
         ("C-S-<down>" . nil)
         ("S-<up>" . nil)
         ("S-<down>" . nil)))

(use-package! org-agenda
  :bind* (:map org-agenda-mode-map
          ("z" . org-agenda-undo)))

(global-set-key (kbd "M-<down>") 'other-window)
(global-unset-key (kbd "C-x O"))
(defun other-window-back ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "M-<up>") 'other-window-back)

(global-set-key (kbd "<escape>") 'keyboard-quit)

(global-set-key (kbd "M-[") 'previous-buffer)
(global-set-key (kbd "M-]") 'next-buffer)

(use-package! helm
  :init
  (require 'helm-projectile)
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
  (setq helm-mini-default-sources
        '(helm-source-buffers-list helm-source-recentf helm-source-projectile-files-list))
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

(use-package! helm-projectile)

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
(global-undo-tree-mode +1)

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

;; (set-popup-rule! "\\*compilation" :side 'right :width 0.5 :modeline t)
;; (plist-put +popup-defaults :modeline t)
;;
(global-auto-revert-mode +1)

(setq-default cursor-type '(bar . 3))

(use-package! json-mode
  :init (setq js-indent-level 2))

(use-package! rst-mode
  :bind (:map rst-mode-map
         ("<tab>" . indent-rigidly-right)
         ("<backtab>" . indent-rigidly-left)))

(use-package! lsp-mode
  :bind (:map lsp-mode-map
         ("M-." . lsp-goto-type-definition)
         ("M-<RET>" . lsp-execute-code-action)
         ("C-q" . lsp-describe-thing-at-point)))

(use-package! git-commit
  :custom
  (git-commit-summary-max-length 70))

(use-package! dap-mode
  :bind (:map dap-mode-map
         ("<f8>" . dap-breakpoint-toggle)
         ("C-<f8>" . dap-breakpoint-condition)
         ("<f9>" . dap-debug)
         ("C-9" . dap-debug)
         ("<f7>" . dap-ui-expressions)
         ("C-S-<f8>" . dap-ui-breakpoints)
         ("<f10>" . dap-go-to-output-buffer))
  :custom
  (dap-auto-configure-features '())
  (dap-auto-show-output nil)
  (dap-output-window-max-height 10)
  (dap-output-window-max-height 20)
  :init
  (add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra))))

(use-package! git-gutter
  :init
  (global-set-key (kbd "C-M-z") 'git-gutter:revert-hunk)
  (global-set-key (kbd "M-<next>") 'git-gutter:next-hunk)
  (global-set-key (kbd "M-<prior>") 'git-gutter:previous-hunk))

(use-package! treemacs
  :bind (:map treemacs-mode-map
         ("M-<up>" . other-window-back)
         ("M-<down>" . other-window)))

(use-package! projectile
  :bind (:map global-map
         ("C-8" . projectile-test-project)
         ("M-r" . projectile-test-project)))

(use-package! compile
  :ensure nil
  :init
  ;; Add NodeJS error format
  (setq compilation-error-regexp-alist-alist
        (cons '(node "^[  ]+at \\(?:[^\(\n]+ \(\\)?\\([a-zA-Z\.0-9_/-]+\\):\\([0-9]+\\):\\([0-9]+\\)\)?$"
                     1 ;; file
                     2 ;; line
                     3 ;; column
                     )
              compilation-error-regexp-alist-alist))
  (setq compilation-error-regexp-alist
        (cons 'node compilation-error-regexp-alist)))

(use-package! vterm
  :custom (vterm-min-window-width 200))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#f0f0f0" "#e45649" "#50a14f" "#986801" "#4078f2" "#a626a4" "#0184bc" "#383a42"])
 '(custom-safe-themes
   (quote
    ("2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" default)))
 '(fci-rule-color "#383a42")
 '(jdee-db-active-breakpoint-face-colors (cons "#f0f0f0" "#4078f2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#f0f0f0" "#50a14f"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#f0f0f0" "#9ca0a4"))
 '(objed-cursor-color "#e45649")
 '(pdf-view-midnight-colors (cons "#383a42" "#fafafa"))
 '(rustic-ansi-faces
   ["#fafafa" "#e45649" "#50a14f" "#986801" "#4078f2" "#a626a4" "#0184bc" "#383a42"])
 '(safe-local-variable-values
   (quote
    ((js2-strict-missing-semi-warning)
     (js2-basic-offset . 2))))
 '(sp-override-key-bindings (quote (("C-<right>") ("C-<left>"))))
 '(vc-annotate-background "#fafafa")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50a14f")
    (cons 40 "#688e35")
    (cons 60 "#807b1b")
    (cons 80 "#986801")
    (cons 100 "#ae7118")
    (cons 120 "#c37b30")
    (cons 140 "#da8548")
    (cons 160 "#c86566")
    (cons 180 "#b74585")
    (cons 200 "#a626a4")
    (cons 220 "#ba3685")
    (cons 240 "#cf4667")
    (cons 260 "#e45649")
    (cons 280 "#d2685f")
    (cons 300 "#c07b76")
    (cons 320 "#ae8d8d")
    (cons 340 "#383a42")
    (cons 360 "#383a42")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

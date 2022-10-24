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
(if (eq system-type 'gnu/linux)
    (setq doom-font "JetBrainsMono Nerd Font-11")
  (setq doom-font "JetBrainsMono NF-11")
  (setq doom-unicode-font "JetBrainsMono NF-11")
  (setq doom-variable-pitch-font "JetBrainsMono NF-11"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi)

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

(map! "C-<f2>" 'list-processes)

(custom-set-faces!
 '(outline-1 :weight normal)
 '(outline-2 :weight normal)
 '(outline-3 :weight normal)
 '(outline-4 :weight normal)
 '(outline-5 :weight normal)
 '(outline-6 :weight normal))

(use-package! iflipb
  :bind (:map global-map
         ("C-<tab>" . iflipb-next-buffer)
         ("<C-iso-lefttab>" . iflipb-previous-buffer)))

(use-package! magit
  :bind (:map magit-section-mode-map
         ("C-<tab>" . nil)
         ("<C-iso-lefttab>" . nil)))

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
                                  ("windows" . ?w)
                                  ("laptop" . ?l)
                                  ("meet" . ?m)
                                  ("emacs" . ?e)
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
         ("C-<return>" . org-todo)
         ("C-S-<return>" . org-archive-subtree-default)
         ("C-S-<left>" . nil)
         ("C-S-<right>" . nil)
         ("S-<left>" . nil)
         ("S-<right>" . nil)
         ("C-S-<up>" . nil)
         ("C-S-<down>" . nil)
         ("S-<up>" . nil)
         ("S-<down>" . nil)
         :map org-agenda-mode-map
         )
  :custom (org-provide-todo-statistics 'all-headlines))

(use-package! org-agenda
  :bind* (:map org-agenda-mode-map
          ("z" . org-agenda-undo)
          ("C-z" . org-agenda-undo)
          ("C-<return>" . org-agenda-todo)))

(global-set-key (kbd "M-<down>") 'other-window)
(global-unset-key (kbd "C-x O"))
(defun other-window-back ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "M-<up>") 'other-window-back)

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
;; (global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "S-<return>") 'isearch-repeat-backward)
(define-key isearch-mode-map [return] 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-v") 'isearch-yank-kill)
(define-key minibuffer-local-isearch-map (kbd "C-f") 'isearch-forward-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-r") 'isearch-backward-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-v") 'isearch-yank-kill)
(remove-hook 'isearch-mode-hook 'isearch-yank-kill)
(global-set-key (kbd "C-r") 'anzu-query-replace-regexp)
(global-anzu-mode +1)

(global-set-key (kbd "C-f") '+default/search-buffer)
(global-set-key (kbd "C-S-f") '+default/search-project)

(global-set-key (kbd "C-M-<down>") 'next-error)
(global-set-key (kbd "C-M-<up>") (lambda () (interactive) (next-error -1)))

(setq select-enable-clipboard t)
(setq select-active-regions nil)

(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "C-/") 'comment-dwim)))
(add-hook 'conf-mode-hook (lambda () (local-set-key (kbd "C-/") 'comment-dwim)))

(use-package! ahk-mode
  :bind (:map ahk-mode-map
         ("C-/" . comment-dwim)))


(global-set-key [f6] 'toggle-truncate-lines)
(use-package! winner
  :init
  (global-set-key [f2] 'winner-undo)
  (global-set-key [f3] 'winner-redo))

(global-set-key (kbd "C-j") '(lambda () (interactive) (next-line) (join-line)))
(global-set-key (kbd "C-S-j") '(lambda () (interactive) (next-line) (join-line)))

(global-set-key (kbd "C-w") 'kill-this-buffer)
;; (global-set-key (kbd "C-m") 'recenter-top-bottom)
(global-set-key (kbd "C-a") 'mark-whole-buffer)

(use-package! comint
  :bind (:map comint-mode-map
         ("C-d" . comint-delchar-or-maybe-eof)
         ("C-c" . nil)))

(use-package! python-mode
  :bind (:map python-mode-map
         ("<tab>" . python-indent-shift-right)
         ("<backtab>" . python-indent-shift-left)))

(use-package! popup
  :init
  (plist-put +popup-defaults :modeline t)
  (set-popup-rule! "\\*compilation" :side 'bottom :size 0.5 :modeline t))

(global-auto-revert-mode +1)

(setq-default cursor-type '(bar . 3))

(use-package! json-mode
  :init (setq js-indent-level 2))

(use-package! rst-mode
  :bind (:map rst-mode-map
         ("<tab>" . indent-rigidly-right)
         ("<backtab>" . indent-rigidly-left)))

(use-package lsp-mode
  :bind (:map lsp-mode-map
              ("M-." . lsp-find-definition)
              ("M-<RET>" . lsp-execute-code-action)
              ("C-q" . lsp-describe-thing-at-point)
              ("M-7" . lsp-ui-peek-find-references))
  :config
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'")
  :hook ((lsp-mode-hook . (lambda ()
                            (setq-local er/try-expand-list
                                        (append er/try-expand-list '(lsp-extend-selection)))))))

(use-package! dap-mode
  :bind (:map dap-mode-map
         ("<f8>" . dap-breakpoint-toggle)
         ("C-<f8>" . dap-breakpoint-condition)
         ("<f9>" . dap-debug)
         ("C-9" . dap-debug)
         ("M-r" . dap-debug-last)
         ("<f7>" . dap-ui-expressions)
         ("C-S-<f8>" . dap-ui-breakpoints)
         ("<f10>" . dap-go-to-output-buffer)
         ("C-8" . dap-eval-region)
         ("C-M-8" . dap-eval))
  :custom
  (dap-auto-configure-features '(locals expressions tooltip))
  (dap-auto-show-output t)
  (dap-output-window-max-height 10)
  (dap-output-window-max-height 20)
  ;; :init
  ;; (add-hook 'dap-stopped-hook
  ;;           (lambda (arg) (call-interactively #'dap-hydra)))

  )

(use-package! mocha
  :custom (mocha-reporter "spec"))

(use-package! realgud)

(use-package! realgud-node-debug)

(use-package! git-gutter
  :init
  (global-set-key (kbd "C-M-z") 'git-gutter:revert-hunk)
  (global-set-key (kbd "C-<next>") 'git-gutter:next-hunk)
  (global-set-key (kbd "C-<prior>") 'git-gutter:previous-hunk))

(use-package! treemacs
  :bind (:map treemacs-mode-map
              ("M-<up>" . other-window-back)
              ("M-<down>" . other-window)))

(defun projectile-test-rerun ()
  (interactive)
  (let ((compilation-read-command nil))
    (call-interactively 'projectile-test-project)))

(use-package! projectile
  :bind (:map projectile-mode-map
              ("C-S-t" . projectile-toggle-between-implementation-and-test)
              ("C-8" . projectile-run-async-shell-command-in-root)
              ("C-0" . project-compile)
              ("M-r" . recompile)
              ("M-9" . magit-status)
              ("C-e" . projectile-find-file)))

(use-package! anaconda-mode
  :bind (:map anaconda-mode-map
              ("M-r" . recompile)))
(use-package! compile
  :ensure nil
  :init
  ;; Add NodeJS error format
  (setq compilation-error-regexp-alist-alist
        (cons '(node "^[  ]+at \\(?:[^\(\n]+ \(\\)?\\([@a-zA-Z\.0-9_/-]+\\):\\([0-9]+\\):\\([0-9]+\\)\)?$"
                1 ;; file
                2 ;; line
                3 ;; column
                )
              compilation-error-regexp-alist-alist))
  (setq compilation-error-regexp-alist
        (cons 'node compilation-error-regexp-alist)))


(use-package! vterm
  :bind (:map vterm-mode-map
              ("C-z" . vterm-undo)
              ("C-v" . vterm-yank)
              ("C-<backspace>" . vterm-send-meta-backspace)
              ("C-<delete>" . vterm-send-M-d)
              ("C-S-<SPC>" . vterm-copy-mode)
              ("C-w" . kill-this-buffer))
  :custom (vterm-min-window-width 200)
          (vterm-shell "/bin/bash -l")
  :init
  (add-hook 'vterm-mode-hook 'compilation-shell-minor-mode)
  )

(use-package! tide
  :bind (:map tide-mode-map
         ("C-q" . tide-documentation-at-point)))

(use-package! better-jumper
  :bind (("M-[" . better-jumper-jump-backward)
         ("M-]" . better-jumper-jump-forward))
  :config
  (defadvice beginning-of-buffer (before better-jumper activate)
      (when (bound-and-true-p better-jumper-local-mode)
        (better-jumper-set-jump)))

  (defadvice mark-whole-buffer (before better-jumper activate)
      (when (bound-and-true-p better-jumper-local-mode)
        (better-jumper-set-jump)))

  (defadvice +default/search-buffer (before better-jumper activate)
      (when (bound-and-true-p better-jumper-local-mode)
        (better-jumper-set-jump)))

  (defadvice end-of-buffer (before better-jumper activate)
      (when (bound-and-true-p better-jumper-local-mode)
        (better-jumper-set-jump))))

(use-package! shell
  :ensure nil
  :init (setq shell-prompt-pattern "^[^#$%>\n]*[#$%>➜] *"))


(after! git-gutter-fringe
  (fringe-mode 12))

(setq w32-pass-lwindow-to-system nil)
(setq w32-pass-rwindow-to-system nil)

(use-package! spell-fu
  :bind ("M-$" . +spell/add-word))

(use-package! jest-test-mode
  :ensure t
  :commands jest-test-mode
  :hook (typescript-mode js-mode typescript-tsx-mode))

(use-package! multi-cursors
  :bind (("M-j" . mc/mark-next-like-this)
         ("M-C-j" . mc/mark-all-like-this)
         ("M-J" . mc/unmark-next-like-this)
         :map mc/keymap
         ("<return>" . nil)
         ("C-v" . nil)
         ("M-v" . nil)
         ("M-<down>" . mc/cycle-forward)
         ("M-<up>" . mc/cycle-backward)))

(use-package! jenkinsfile-mode)

(use-package! ein-notebook
  :bind (:map ein:notebook-mode-map
         ("C-<return>" . ein:worksheet-execute-cell-km)
         ("M-<up>" . nil)
         ("M-<down>" . nil)))

(global-subword-mode +1)
(blink-cursor-mode +1)

(global-set-key (kbd "C-p") 'delete-other-windows)

(defun aleksei/copy-line-or-region ()
  "Copy the region if it's active otherwise copy current line"
  (interactive)
  (if (region-active-p)
      (call-interactively 'kill-ring-save)
    (save-excursion
      (call-interactively
       '(lambda ()
          (interactive)
          (copy-region-as-kill
           (progn (beginning-of-line) (point))
           (progn (end-of-line) (point))))))))

(defun aleksei/cut-line-or-region ()
  "Cut the region if it's active otherwise cut current line"
  (interactive)
  (if (region-active-p)
        (call-interactively 'kill-region)
    (save-excursion
      (call-interactively 'kill-whole-line))))

;; We don't need cua-mode!
(defun aleksei/define-global-key-translations (&optional frame)
  "Re-map C-x/c/v and ESC according modern conventions"
  (with-selected-frame (or frame (selected-frame))
    ;; C-x
    (keyboard-translate ?\C-t ?\C-x)
    (keyboard-translate ?\C-x 'control-x)
    (global-set-key [control-x] 'aleksei/cut-line-or-region)
    ;; C-c
    (keyboard-translate ?\C-d ?\C-c)
    (keyboard-translate ?\C-c 'control-c)
    (global-set-key [control-c] 'aleksei/copy-line-or-region)
    ;; C-v
    (keyboard-translate ?\C-v 'control-v)
    (global-set-key [control-v] 'yank)
    ;; Escape
    (define-key key-translation-map (kbd "ESC") (kbd "C-g"))))

(after! doom-keybinds
  (aleksei/define-global-key-translations)
  (add-hook 'after-make-frame-functions 'aleksei/define-global-key-translations)
  (global-unset-key (kbd "C-<return>")))

(use-package! undo-fu
  :bind (:map global-map
              ("C-z"   . undo-fu-only-undo)
              ("C-S-z" . undo-fu-only-redo)))

(use-package! vertico
  :bind (:map minibuffer-local-map
         ("C-f" . consult-history)
         ("C-r" . consult-history)
         ("C-s" . nil)
         ("<prior>" . vertico-scroll-down)
         ("<next>" . vertico-scroll-up)
         :map global-map
              ("C-b" . +vertico/switch-workspace-buffer)))

(use-package! embark
  :bind (:map global-map
             ("M-<return>" . embark-act)
         :map minibuffer-local-map
              ("M-<return>" . embark-act)
         :map minibuffer-mode-map
              ("M-<return>" . embark-act)))

(use-package! info
  :bind (:map Info-mode-map
              ("M-[" . Info-history-back)
              ("M-]" . Info-history-forward)))

(use-package! emacs
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-region '(bg-only no-extend)
        modus-themes-lang-checkers '(straight-underline)
        modus-themes-paren-match '(bold)
        modus-themes-org-blocks 'gray-background
        modus-themes-mode-line '(borderless accented)
        modus-themes-diffs '(bg-only)))

(use-package! emacs
  :bind (:map global-map
              ("C-/" . comment-dwim)))

(use-package! doom-modeline
  :custom (doom-modeline-height 30))

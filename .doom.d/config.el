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
(defun aleksei/font-size ()
  "Returns font size depending on the environment. Currently I use a smaller font on Wayland"
  13)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size (aleksei/font-size) :weight 'medium)
      doom-unicode-font doom-font
      doom-variable-pitch-font (font-spec :family "sans" :size (aleksei/font-size)))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(use-package! emacs
  :init
  (defun aleksei/set-colors-for-current-theme ()
    "Sets variables like `lsp-ui-doc-border' to good colors according
to the current theme"
    (setq lsp-ui-doc-border (modus-themes-color 'fg-main)))
  (setq lsp-ui-doc-border "#000000")


  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-region '(bg-only no-extend)
        modus-themes-lang-checkers '(straight-underline)
        modus-themes-paren-match '(bold)
        modus-themes-org-blocks 'gray-background
        modus-themes-mode-line '(borderless accented))
  :hook (modus-themes-after-load-theme . aleksei/set-colors-for-current-theme))
(setq doom-theme 'modus-operandi)

(after! doom-ui
  (setq! auto-dark-dark-theme 'modus-vivendi
         auto-dark-light-theme 'modus-operandi)
  (auto-dark-mode 1))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")

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
(map! "C-d" 'duplicate-dwim)

(use-package! magit
  :bind (:map magit-section-mode-map
         ("C-<tab>" . nil)
         ("<C-iso-lefttab>" . nil)
         :map magit-mode-map
         ("C-w" . delete-window)))

(use-package! smartparens
  :config
  (defun aleksei/sp-beginning-or-end-of-sexp ()
    "Move to the beginning of sexp if not at the beginning, otherwise move to the end of sexp."
    (interactive)
    (let ((initial-point (point)))
      (sp-beginning-of-sexp)
      (when (eq initial-point (point))
        (sp-end-of-sexp))))
  (custom-set-variables
   '(sp-override-key-bindings
     '(("C-<right>" . nil)
       ("C-<left>" . nil)
       ("M-m" . aleksei/sp-beginning-or-end-of-sexp)
       ("C-M-k"  . nil)
       ("C-M-t" . nil)
       ("C-M-e" . nil)))))

(defun aleksei/org-gtd ()
  "Prepare emacs frame to use as a GTD system."
  (interactive)
  (require 'org)
  ;; (dolist (f org-agenda-files)
  ;;   (find-file (concat org-directory "/" f)))
  (find-file (concat org-directory "/tasks.org" ))
  (org-agenda-list))

(defun gusev/org-todo-convert-to-project ()
  (interactive)
  (save-excursion
    (org-todo "")
    (goto-char (point-at-bol))
    (if (looking-at "\\(**+\\) ")
        (replace-match "\\1 [/] ")))
  (call-interactively 'org-insert-todo-subheading))

(defun aleksei/org-capture ()
  "Opens a new frame with Org capture inbox template"
  (interactive)
  (add-hook 'org-capture-after-finalize-hook 'kill-emacs)
  (org-capture "" "i")
  (delete-other-windows))

(use-package! org
  :hook (;; (org-mode . variable-pitch-mode)
         (org-mode . (lambda ()
                       (toggle-truncate-lines -1)
                       (toggle-word-wrap +1))))
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
                  org-agenda-custom-commands
                  '(("n" "NA" tags-tree org-agenda-na-expr))
                  org-agenda-files '("tasks.org" "forenom.org" "tickler.org" "inbox.org")
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
              ("C-c C-e" . gusev/org-todo-convert-to-project)
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
              ("M-S-<down>" . org-move-subtree-down))
  :custom (org-provide-todo-statistics 'all-headlines))

(use-package! org-agenda
  :bind* (:map org-agenda-mode-map
               ("z" . org-agenda-undo)
               ("C-z" . org-agenda-undo)
               ("C-<return>" . org-agenda-todo)))

(use-package! org-capture
  :config
  (setq +org-capture-frame-parameters '((name . "doom-capture")
                                        (left . (+ 1142))
                                        (top . (+ 450))
                                        (width . 101)
                                        (height . 25)
                                        (transient . t)
                                        nil)))

(setq-default tab-width 2)

(use-package! emacs
  :bind (:map emacs-lisp-mode-map
              ("C-q" . describe-symbol))
  :hook ((emacs-lisp-mode . (lambda () (setq tab-width 2)))))

(use-package! ert
  :bind (:map emacs-lisp-mode-map
              ("C-; f" . ert)))

(use-package! expand-region
  :init
  (global-set-key (kbd "C-h") 'er/expand-region)
  (global-set-key (kbd "C-S-h") (lambda () (interactive) (er/expand-region -1))))

(use-package! crux
  :bind (("<home>" . crux-move-beginning-of-line)))

(global-set-key (kbd "C-M-l") 'indent-region)

(global-set-key (kbd "C-s") (lambda () (interactive) (save-some-buffers +1)))

(global-unset-key (kbd "M-<up>"))
(global-unset-key (kbd "M-<down>"))
(global-set-key (kbd "M-S-<up>") 'drag-stuff-up)
(global-set-key (kbd "M-S-<down>") 'drag-stuff-down)

(defun aleksei/isearch-region-or-forward ()
  "Do incremental search forward, use region if it's active"
  (interactive)
  (if (use-region-p)
      (isearch-forward-thing-at-point)
    (isearch-forward)))

(setq search-exit-option 'edit)
(global-set-key (kbd "C-f") 'aleksei/isearch-region-or-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "S-<return>") 'isearch-repeat-backward)
(define-key isearch-mode-map [return] 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-g") 'isearch-exit)
(define-key isearch-mode-map (kbd "C-v") 'isearch-yank-kill)
(define-key minibuffer-local-isearch-map (kbd "C-f") 'isearch-forward-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-r") 'isearch-backward-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-v") 'isearch-yank-kill)
(remove-hook 'isearch-mode-hook 'isearch-yank-kill)
(global-set-key (kbd "C-r") 'anzu-query-replace-regexp)
(global-anzu-mode +1)

(global-set-key (kbd "M-f") '+default/search-buffer)
(global-set-key (kbd "C-S-f") '+default/search-project)
(global-set-key (kbd "C-S-r") 'projectile-replace)

(global-set-key (kbd "C-M-<down>") 'next-error)
(global-set-key (kbd "C-M-<up>") (lambda () (interactive) (next-error -1)))

(setq select-enable-clipboard t)
(setq select-active-regions nil)


(global-set-key [f6] 'toggle-truncate-lines)
(use-package! winner
  :init
  (global-set-key [f3] 'winner-undo)
  (global-set-key [f4] 'winner-redo))

(global-set-key (kbd "C-j") '(lambda () (interactive) (next-line) (join-line)))
(global-set-key (kbd "C-S-j") '(lambda () (interactive) (next-line) (join-line)))

(global-set-key (kbd "C-w") 'delete-window)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-S-b") 'switch-to-buffer)

(use-package! comint
  :bind (:map comint-mode-map
              ("C-d" . comint-delchar-or-maybe-eof)
              ("C-c" . nil)
              ("M-<up>" . comint-previous-prompt)
              ("M-<down>" . comint-next-prompt)))

(use-package! python-mode
  :bind (:map python-mode-map
              ("<tab>" . python-indent-shift-right)
              ("<backtab>" . python-indent-shift-left)))

(load! "configs/windows.el")

(global-auto-revert-mode +1)

(setq-default cursor-type '(bar . 3))

(use-package! rst-mode
  :bind (:map rst-mode-map
              ("<tab>" . indent-rigidly-right)
              ("<backtab>" . indent-rigidly-left)))

(use-package lsp-mode
  :init
  (defun lsp-ui-doc-show-or-focus ()
    "Show hover information popup, focus it if it's already shown"
    (interactive)
    (if (lsp-ui-doc--visible-p)
        (lsp-ui-doc-focus-frame)
      (lsp-ui-doc-glance)))

  :bind (:map lsp-mode-map
              ("C-q" . lsp-ui-doc-show-or-focus)
              ("M-<RET>" . lsp-execute-code-action)
              ("C-S-q" . lsp-rust-analyzer-open-external-docs)
              ("C-t" . lsp-rename)
              ("C-." . lsp-execute-code-action)
              ("C-S-o" . consult-lsp-file-symbols))

  :config
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'")
  :hook ((lsp-mode-hook . (lambda ()
                            (setq-local er/try-expand-list
                                        (append er/try-expand-list '(lsp-extend-selection))))))
  :custom
  (lsp-ui-sideline-diagnostic-max-lines 10)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-doc-max-height 13)
  (lsp-eslint-experimental-incremental-sync t)
  (lsp-modeline-diagnostics-enable nil)
  (lsp-modeline-workspace-status-enable nil)
  (lsp-lens-enable nil)
  (lsp-eslint-run "onType"))

(load! "configs/flycheck")
(load! "configs/dap-mode")

(use-package! mocha
  :custom (mocha-reporter "spec"))

(use-package! diff-hl
  :bind (:map diff-hl-mode-map
              ("C-M-z" . +vc-gutter/revert-hunk)
              ("M-[" . +vc-gutter/previous-hunk)
              ("M-]" . +vc-gutter/next-hunk)
              ("C-'" . diff-hl-show-hunk)))

(defun aleksei/compile ()
  "Run compilation command in project root or just in current dir"
  (interactive)
  (if (projectile-project-root)
      (call-interactively 'projectile-compile-project)
    (call-interactively 'compile)))

(use-package! projectile
  :bind (:map projectile-mode-map
              ("C-S-t" . projectile-toggle-between-implementation-and-test)
              ("C-8" . projectile-run-async-shell-command-in-root)
              ("M-9" . magit-status)
              ("C-e" . projectile-find-file)))

(use-package! emacs
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
        (cons 'node compilation-error-regexp-alist))

  (setq compilation-error-regexp-alist-alist
        (cons '(webpack-ts-error "\\(\\./[^: \n]+\\):\\([0-9]+\\):\\([0-9]+\\)"
                1 ;; file
                2 ;; line
                3 ;; column
                )
              compilation-error-regexp-alist-alist))
  (setq compilation-error-regexp-alist
        (cons 'webpack-ts-error compilation-error-regexp-alist)))

(use-package! vterm
  :bind (:map global-map
         ("C-`" . +vterm/toggle)
         :map vterm-mode-map
         ("C-z" . vterm-undo)
         ("C-v" . vterm-yank)
         ("C-<backspace>" . vterm-send-meta-backspace)
         ("C-<delete>" . vterm--self-insert)
         ("C-S-<SPC>" . vterm-copy-mode)
         ("C-w" . delete-window)
         ("C-S-b" . +vertico/switch-workspace-buffer)
         ("C-b" . switch-to-buffer)
         ("M-<up>" . aleksei/vterm-copy-mode-previous-prompt)
         ("M-<down>" . aleksei/vterm-copy-mode-next-prompt)
         ("C-t" . aleksei/vterm-new-tab)
         :map vterm-copy-mode-map
         ("M-<up>" . vterm-previous-prompt)
         ("M-<down>" . vterm-next-prompt)
         ("C-t" . aleksei/vterm-new-tab))
  :custom
  (vterm-shell "/bin/bash -l")
  (vterm-max-scrollback 100000)
  :init
  (add-hook 'vterm-mode-hook 'compilation-shell-minor-mode)
  (add-hook 'vterm-mode-hook '(lambda () (setq-local cua-mode nil)))
  (remove-hook 'vterm-mode-hook #'hide-mode-line-mode)

  (defun aleksei/vterm-copy-mode-next-prompt ()
    (interactive)
    (vterm-copy-mode)
    (call-interactively #'vterm-next-prompt))

  (defun aleksei/vterm-copy-mode-previous-prompt ()
    (interactive)
    (vterm-copy-mode)
    (call-interactively #'vterm-previous-prompt))

  (defun aleksei/vterm-new-tab ()
    (interactive)
    (vterm 'new)))

(use-package! tide
  :bind (:map tide-mode-map
              ("C-q" . tide-documentation-at-point)))

(use-package! better-jumper
  :bind (("M-<left>" . better-jumper-jump-backward)
         ("M-<right>" . better-jumper-jump-forward))
  :config
  (setq aleksei/better-jumper-advice-funcs
        '(beginning-of-buffer
          end-of-buffer
          mark-whole-buffer
          +default/search-project
          +default/search-buffer
          consult-lsp-symbols
          aleksei/isearch-region-or-forward
          isearch-forward
          isearch-backward
          flycheck-next-error
          flycheck-previous-error))

  (dolist (func aleksei/better-jumper-advice-funcs)
    (eval `(defadvice ,func (before better-jumper activate)
             (when (bound-and-true-p better-jumper-local-mode)
               (better-jumper-set-jump))))))

(use-package! shell
  :ensure nil
  :init (setq shell-prompt-pattern "^[^#$%>\n]*[#$%>➜] *"))


(setq w32-pass-lwindow-to-system nil)
(setq w32-pass-rwindow-to-system nil)

(use-package! multiple-cursors-core
  :bind (("M-j" . mc/mark-next-like-this)
         ("M-C-j" . mc/mark-all-like-this)
         ("M-J" . mc/skip-to-next-like-this)
         :map mc/keymap
         ("<return>" . nil)
         ("C-v" . nil)
         ("M-v" . nil)
         ("M-n" . mc/cycle-forward)
         ("M-p" . mc/cycle-backward))
  :custom
  (mc/match-cursor-style nil))

(use-package! ein-notebook
  :bind (:map ein:notebook-mode-map
              ("C-<return>" . ein:worksheet-execute-cell-km)
              ("M-<up>" . ein:worksheet-move-cell-up)
              ("M-<down>" . ein:worksheet-move-cell-down)))
(require 'ob-ein)

(global-subword-mode +1)
(blink-cursor-mode +1)

(global-set-key (kbd "C-p") 'window-toggle-side-windows)

;; (load! "configs/cua-modernized")
(load! "configs/just-cua")

(use-package! undo-fu
  :bind (:map global-map
              ("C-z"   . undo-fu-only-undo)
              ("C-S-z" . undo-fu-only-redo)))

(use-package! consult
  :bind (:map global-map
         ("C-b" . consult-buffer)
         :map minibuffer-local-map
         ("C-f" . consult-history)
         ("C-r" . consult-history)))

(use-package! vertico
  :bind (:map minibuffer-local-map
              ("C-s" . nil)
              ("<prior>" . vertico-scroll-down)
              ("<next>" . vertico-scroll-up)
              ("C-j" . vertico-exit-input)))

(use-package! embark
  :bind (:map global-map
         ("M-<return>" . embark-act)
         ("C-;" . nil)
         :map minibuffer-local-map
         ("M-<return>" . embark-act)
         :map minibuffer-mode-map
         ("M-<return>" . embark-act))
  :custom
  (embark-indicators '(embark--vertico-indicator
                       embark-highlight-indicator
                       embark-isearch-highlight-indicator))
  (embark-prompter 'embark-completing-read-prompter))

(use-package! info
  :bind (:map Info-mode-map
              ("M-[" . Info-history-back)
              ("M-]" . Info-history-forward)))

;;;###autoload
(defun aleksei/comment-dwim (&optional arg)
  "Comment/uncomment region if active, other do the same with current line.

There is subtle difference between this function and
`comment-line'. Basically, when commenting region this function
respects region boundaries extactly. This is especially useful
lisp like languages when you might want to comment only some part
of a line"
  (interactive "*P")
  (comment-normalize-vars)
  (if (use-region-p)
      (comment-or-uncomment-region (region-beginning) (region-end) arg)
    (call-interactively #'comment-line 1)))

(use-package! emacs
  :bind (:map global-map
              ("C-/" . aleksei/comment-dwim)
              ("M-t" . aleksei/compile)
              ("M-r" . recompile)
              ("C-M-l" . +format/region-or-buffer)
              ("M-C-." . +lookup/type-definition)
              ("M-." . +lookup/definition)
              ("M->" . +lookup/references)
              ("C-q" . +lookup/documentation)
              ("S-RET" . +default/diagnostics)
              ("C-S-o" . imenu)
              ("C-M-o" . consult-imenu-multi)))

(load! "configs/doom-modeline")

(setq +format-with-lsp nil)

(use-package! emacs
  :custom
  (ls-lisp-dirs-first t))

(load! "configs/eshell")

(use-package! doom-modeline
  :config
  (setq doom-modeline-major-mode-icon t
        doom-modeline-buffer-file-name-style 'file-name))

(defun aleksei/buffer-file-name-for-frame-title ()
  (let ((doom-modeline-buffer-file-name-style 'relative-to-project))
    (doom-modeline-buffer-file-name)))

(use-package! emacs
  :config
  (setq frame-title-format '((:eval (aleksei/buffer-file-name-for-frame-title))
                             (:eval (concat " - " (projectile-project-name))))
        icon-title-format frame-title-format))


(use-package! fd-dired
  :config
  (setq fd-dired-program "fdfind"))

(use-package! dired
  :config
  (setq delete-by-moving-to-trash t))

(load! "configs/git-link")

(add-to-list 'auto-mode-alist '("Cask$" . emacs-lisp-mode))

(use-package! sql
  :custom
  (sql-connection-alist
   '(("local/spaceship:slap"
      (sql-product 'postgres)
      (sql-server "localhost")
      (sql-database "spaceship")
      (sql-user "spaceship"))
     )))

(use-package! emacs
  :bind (("C-=" . +fold/toggle)
         ("C-k" . +fold/toggle)
         ("C-M-k" . +fold/open-all)
         ("M-k" . +fold/close-all)))


(defun aleksei/string-inflection-cycle-auto ()
  "switching by major-mode"
  (interactive)
  (cond
   ;; for emacs-lisp-mode
   ((eq major-mode 'emacs-lisp-mode)
    (string-inflection-all-cycle))
   ;; for python
   ((eq major-mode 'python-mode)
    (string-inflection-python-style-cycle))
   ;; for java
   ((eq major-mode 'java-mode)
    (string-inflection-java-style-cycle))
   ;; for elixir
   ((eq major-mode 'elixir-mode)
    (string-inflection-elixir-style-cycle))
   (t
    ;; default
    (string-inflection-ruby-style-cycle))))

(use-package! string-inflection
  :bind (("C-M-t" . aleksei/string-inflection-cycle-auto)))

(use-package! separedit
  :bind (:map prog-mode-map
         ("C-c '" . separedit)
         :map minibuffer-local-map
         ("C-c '" . separedit)
         :map prog-mode-map
         ("C-c '" . separedit)
         :map help-mode-map
         ("C-c '" . separedit)
         :map helpful-mode-map
         ("C-c '" . separedit))
  :init
  (setq separedit-save-key (kbd "C-s"))
  :custom
  (separedit-default-mode 'sql-mode))

(context-menu-mode +1)

(after! man
  (remove-hook 'Man-mode-hook 'hide-mode-line-mode))

(use-package! rustic
  :hook
  ((rustic-mode . (lambda () (require 'rust-compile))))
  :bind (:map rustic-mode-map
              ("M-r" . rustic-cargo-test-rerun)))

(use-package! rg
  :custom
  (rg-executable "rg"))

(use-package! corfu
  :config
  (setq corfu-preview-current nil)
  (remove-hook! corfu-mode '+corfu-mode-unbinds)
  :bind (:map global-map
         ("C-SPC" . completion-at-point)
         :map corfu-map
         ("<return>" . corfu-complete)
         ("<home>" . corfu-first)
         ("<end>" . corfu-last)
         ("<prior>" . corfu-scroll-down)
         ("<next>" . corfu-scroll-up)
         ("M-v" . nil)
         ("C-v" . nil)))


(use-package! kbd-mode)
(use-package! yaml-mode
  :bind (:map yaml-mode-map
              ("<backspace>" . backward-delete-char-untabify)))

(use-package! gptel
  :bind (:map global-map
              ("C-<return>" . gptel-menu)
              ;; :map gptel-mode
              ;; ("C-<return>" . gptel-send)
              )
  :config (setq gptel-model "gpt-4o"))

(use-package! docker
  :config
  (add-to-list 'auto-mode-alist '("\\.Dockerfile\\'" . dockerfile-mode)))

(use-package! phpunit
  :config
  (defvar-local phpunit-root-directory-in-docker ""
    "Directory path in docker PHPUnit project is mounted to.")
  (put 'phpunit-root-directory-in-docker 'safe-local-variable #'stringp)

  (defun phpunit-test-file-prefix-path ()
    "Returns prefix that should be used when a test run in docker."
    (and phpunit-root-directory-in-docker (concat phpunit-root-directory-in-docker "/")))

  ;;;###autoload
  (defun phpunit-current-test ()
    "Launch PHPUnit on current test."
    (interactive)
    (let* (
           (args (s-concat " --filter '"
			                     (phpunit-get-current-class)
			                     "::"
			                     (phpunit-get-current-test) "'"
                           " "
                           (concat (phpunit-test-file-prefix-path)
                                   (s-chop-prefix (phpunit-get-root-directory) buffer-file-name)))))
      (phpunit-run args)))

  ;;;###autoload
  (defun phpunit-current-class ()
    "Launch PHPUnit on current class."
    (interactive)

    (phpunit-run (concat (phpunit-test-file-prefix-path)
                         (s-chop-prefix (phpunit-get-root-directory t) buffer-file-name))))

  (defvar aleksei/phpunit-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "f") 'phpunit-current-class)
      (define-key map (kbd "c") 'phpunit-current-test)
      (define-key map (kbd "a") 'phpunit-current-project)
      (define-key map (kbd "l") 'recompile)
      map))

  :bind-keymap* ("C-;" . aleksei/phpunit-mode-map))

(use-package! flyspell
  :bind (:map flyspell-mode-map
              ("C-;" . nil)))

(use-package! scroll-on-jump
  :config

  (let ((funcs-to-advice '(forward-paragraph
                           backward-paragraph
                           beginning-of-buffer
                           end-of-buffer
                           isearch-forward
                           isearch-backward
                           isearch-forward-thing-at-point
                           isearch-repeat-forward
                           better-jumper-jump-forward
                           better-jumper-jump-backward
                           )))
    (dolist (func funcs-to-advice)
      (eval `(scroll-on-jump-advice-add ,func))))

  (let ((funcs '(cua-scroll-up
                 cua-scroll-down
                 recenter-top-bottom)))
    (dolist (func funcs)
      (eval `(scroll-on-jump-with-scroll-advice-add ,func)))))

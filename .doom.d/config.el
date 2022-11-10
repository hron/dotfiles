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
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'semi-bold)
      doom-unicode-font doom-font
      doom-variable-pitch-font (font-spec :family "sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi)

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

(use-package! emacs
  :config
  (setq-default line-spacing 3))

(map! "C-<f2>" 'list-processes)

(use-package! iflipb
  :bind (:map global-map
              ("C-<tab>" . iflipb-next-buffer)
              ("<C-iso-lefttab>" . iflipb-previous-buffer)))

(use-package! magit
  :bind (:map magit-section-mode-map
              ("C-<tab>" . nil)
              ("<C-iso-lefttab>" . nil)))

(use-package! magit-gitflow
  :bind (:map magit-gitflow-mode-map
              ("C-f" . nil)))

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
    (modify-frame-parameters nil '((icon-type . tasks-icon)
                                   (auro-raise . t)
                                   (left . (+ 5))
                                   (top . (+ 38))
                                   (width . 101)
                                   (height . 59)))))

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
  (+org-capture/open-frame "" "i"))

(use-package! org
  :config (progn
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
                  org-agenda-files '("tasks.org" "f-secure.org" "tickler.org" "inbox.org")
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
              ("M-<up>" . org-move-subtree-up)
              ("M-<down>" . org-move-subtree-down))
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

;; (load! "configs/indent-rigidly")

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

(use-package! mwim
  :config
  (global-set-key (kbd "<home>") 'mwim-beginning-of-code-or-line))

(global-set-key (kbd "C-M-l") 'indent-region)

(global-set-key (kbd "C-s") (lambda () (interactive) (save-some-buffers +1)))

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

(plist-put +popup-defaults :modeline nil)
(plist-put +popup-defaults :size 0.33)
(set-popup-rules!
  '(
    ("\\*" :size 0.33)
    ("\\*ein" :ignore t)
    ("\\*Org Agenda" :ignore t)
    ("\\*Flycheck errors" :select t)
    ("\\*compilation")
    ("\\*ert")
    ("\\*mocha")
    ("\\*eshell" :select t)
    ("\\*doom:eshell" :select t)))

(use-package! emacs
  :bind (("C-<prior>" . other-window)
         ("C-<next>" . +popup/other)))

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
              ("M-7" . lsp-find-references))
  :config
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'")
  :hook ((lsp-mode-hook . (lambda ()
                            (setq-local er/try-expand-list
                                        (append er/try-expand-list '(lsp-extend-selection))))))
  :custom
  ;; (lsp-ui-sideline-diagnostic-max-lines 5)
  (lsp-ui-sideline-show-diagnostics 10)
  (lsp-eslint-experimental-incremental-sync t))

(use-package! flycheck
  :bind (:map flycheck-mode-map
              ("<f2>" . (lambda ()
                          (interactive)
                          (flycheck-next-error )
                          (flycheck-explain-error-at-point)))
              ("S-<f2>" . (lambda ()
                            (interactive)
                            (flycheck-previous-error)
                            (flycheck-explain-error-at-point)))
              ("C-6" . 'flycheck-list-errors)))

;; (load! "configs/dap-mode.el")

;; Unset company-complete
(global-unset-key (kbd "C-;"))
(use-package! typescript-mode
  :bind (:map typescript-mode-map
              ("C-; f" . mocha-test-file)
              ("C-; c" . mocha-test-at-point)
              ("C-; C-f" . mocha-debug-file)
              ("C-; C-c" . mocha-debug-at-point)))

(use-package! js2-mode
  :bind (:map js2-mode-map
              ("C-; f" . mocha-test-file)
              ("C-; c" . mocha-test-at-point)
              ("C-; C-f" . mocha-debug-file)
              ("C-; C-c" . mocha-debug-at-point)))

(use-package! mocha
  :custom (mocha-reporter "spec"))

(use-package! git-gutter
  :init
  (global-set-key (kbd "C-M-z") 'git-gutter:revert-hunk)
  (global-set-key (kbd "M-<next>") 'git-gutter:next-hunk)
  (global-set-key (kbd "M-<prior>") 'git-gutter:previous-hunk))

(defun projectile-test-rerun ()
  (interactive)
  (let ((compilation-read-command nil))
    (call-interactively 'projectile-test-project)))

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
              ("C-0" . aleksei/compile)
              ("M-r" . recompile)
              ("M-9" . magit-status)
              ("C-e" . projectile-find-file))
  :custom
  (projectile-compile-use-comint-mode t)
  (projectile-create-missing-test-files t))

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
  (add-hook 'vterm-mode-hook '(lambda () (setq-local cua-mode nil)))
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

  (defadvice aleksei/isearch-region-or-forward (before better-jumper activate)
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
         ("M-n" . mc/cycle-forward)
         ("M-p" . mc/cycle-backward))
  :custom
  (mc/match-cursor-style nil))

(use-package! jenkinsfile-mode)

(use-package! ein-notebook
  :bind (:map ein:notebook-mode-map
              ("C-<return>" . ein:worksheet-execute-cell-km)
              ("M-<up>" . ein:worksheet-move-cell-up)
              ("M-<down>" . ein:worksheet-move-cell-down)))

(global-subword-mode +1)
(blink-cursor-mode +1)

(global-set-key (kbd "C-p") 'window-toggle-side-windows)

;; (load! "configs/cua-modernized")
(load! "configs/just-cua")

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
         ("C-j" . vertico-exit-input)
         :map global-map
         ("C-b" . +vertico/switch-workspace-buffer)))

(use-package! embark
  :bind (:map global-map
         ("M-<return>" . embark-act)
         :map minibuffer-local-map
         ("M-<return>" . embark-act)
         :map minibuffer-mode-map
         ("M-<return>" . embark-act))
  :custom
  (embark-prompter 'embark-completing-read-prompter))

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
              ("C-/" . comment-dwim)
              ("M-r" . recompile)))

(use-package! doom-modeline
  :custom (doom-modeline-height 34))

(map! "C-M-l" '+format/region-or-buffer)
(setq +format-with-lsp nil)

(use-package! emacs
  :custom
  (ls-lisp-dirs-first t))

(use-package! esh-mode
  :bind (:map eshell-mode-map
              ("<home>" . eshell-bol)))
(use-package! em-hist
  :bind (:map eshell-hist-mode-map
              ("<up>" . nil)
              ("<down>" . nil)))
(use-package! em-prompt
  :bind (:map eshell-prompt-mode-map
              ("<home>" . eshell-bol)
              ("M-<prior>" . eshell-previous-prompt)
              ("M-<next>" . eshell-next-prompt)))

(use-package! feature-mode
  :config
  (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode)))

(use-package! ace-window
  :bind (:map global-map
             ("C-o" . ace-window)))

(use-package! doom-modeline
  :config
  (setq doom-modeline-buffer-file-name-style 'buffer-name
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t))

(defun aleksei/buffer-file-name-for-frame-title ()
  (let ((doom-modeline-buffer-file-name-style 'relative-to-project))
    (doom-modeline-buffer-file-name)))

(use-package! emacs
  :config
  (setq frame-title-format '((:eval (aleksei/buffer-file-name-for-frame-title))
                             (:eval (concat " - " (projectile-project-name))))
        icon-title-format frame-title-format))


;; (use-package! polymode
;;   :config

;;   (define-hostmode poly-js2-hostmode :mode 'js2-mode)
;;   (define-hostmode poly-typescript-hostmode :mode 'typescript-mode)
;;   (define-hostmode poly-rjsx-hostmode :mode 'rjsx-mode)

;;   (define-innermode poly-js-sql-expr-innermode
;;     :mode 'sql-mode
;;     :head-matcher "`--sql\n"
;;     :tail-matcher "`\n"
;;     :head-mode 'host
;;     :tail-mode 'host)

;;   ;; (dolist (hostmode '("js" "js2" "typescript" "rjsx"))
;;   ;;   (let ((poly-mode-name (intern (concat "poly-" hostmode "-mode")))
;;   ;;         (poly-hostmode-name (intern (concat "poly-" hostmode "-hostmode"))))
;;   ;;     (define-polymode poly-mode-name
;;   ;;       :hostmode poly-hostmode-name
;;   ;;       :innermodes '(poly-js-sql-expr-innermode))))

;;   (define-polymode poly-js-mode
;;     :hostmode 'poly-js-hostmode
;;     :innermodes '(poly-js-sql-expr-innermode))
;;   (define-polymode poly-js2-mode
;;     :hostmode 'poly-js2-hostmode
;;     :innermodes '(poly-js-sql-expr-innermode))
;;   (define-polymode poly-typescript-mode
;;     :hostmode 'poly-typescript-hostmode
;;     :innermodes '(poly-js-sql-expr-innermode))
;;   (define-polymode poly-rjsx-mode
;;     :hostmode 'poly-rjsx-hostmode
;;     :innermodes '(poly-js-sql-expr-innermode))

;;   (add-to-list 'auto-mode-alist '("\.js$" . poly-rjsx-mode))
;;   (add-to-list 'auto-mode-alist '("\.ts$" . poly-typescript-mode)))

(use-package! fd-dired
  :config
  (setq fd-dired-program "fdfind"))

(load! "configs/git-link")

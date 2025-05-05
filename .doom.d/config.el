;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-bold)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(defun aleksei/font-size ()
  "Return font size depending on the environment."
  13)

;; (setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size (aleksei/font-size))
;;       doom-symbol-font doom-font
;;       doom-variable-pitch-font (font-spec :family "sans" :size (aleksei/font-size)))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size (aleksei/font-size) :weight 'normal)
      doom-symbol-font doom-font
      doom-variable-pitch-font (font-spec :family "sans" :size (aleksei/font-size)))

(use-package emacs
  :defer t
  :config
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-common-palette-overrides
        '(;; Make the region to change only the background
          (bg-region bg-ochre)
          (fg-region unspecified)))

  (defun algus/apply-theme-customizations ()
    (modus-themes-with-colors
      (custom-set-faces
       ;; Do not extend it to the end of the line
       `(region ((t :extend nil)))
       ;; `(flycheck-posframe-border-face ((t :foreground ,border)))
       )))
  
  :hook ((modus-themes-after-load-theme . #'algus/apply-theme-customizations)))

(use-package auto-dark
  :defer nil
  :config
  (add-hook 'desktop-after-read-hook #'doom/reload-theme)
  (after! doom-ui
    (setq! auto-dark-dark-theme 'modus-vivendi
           auto-dark-light-theme 'modus-operandi)
    (auto-dark-mode 1)))

(use-package emacs
  :defer t
  :config
  (setq-default cursor-type '(bar . 3))
  (setq w32-pass-lwindow-to-system nil
        w32-pass-rwindow-to-system nil)

  (global-auto-revert-mode +1)
  (global-subword-mode +1)
  (blink-cursor-mode +1)
  (context-menu-mode +1)
  (pixel-scroll-precision-mode +1)

  ;;;###autoload
  (defun aleksei/comment-dwim (&optional arg)
    "Replacement for `comment-dwim'.
 If no region is selected and point is not at the end of the line,
 comment or uncomment the current line. Otherwise, call `comment-dwim'."
    (interactive "*P")
    (if (and (not (use-region-p))
             (not (and (looking-back "^[[:blank:]]*") (looking-at "[[:blank:]]*$"))))
        (comment-or-uncomment-region (line-beginning-position) (line-end-position))
      (comment-dwim arg)))

  :bind (("C-<f2>" . #'list-processes)
         ("C-d" . #'duplicate-dwim)
         ("C-s" . (lambda () (interactive) (save-some-buffers +1)))
         ("M-<up>" . nil)
         ("M-<down>" . nil)
         ("M-S-<up>" . #'drag-stuff-up)
         ("M-S-<down>" . #'drag-stuff-down)
         ("<f6>" . #'toggle-truncate-lines)
         ("C-j" . (lambda () (interactive) (forward-line) (join-line)))
         ("C-S-j" . (lambda () (interactive) (forward-line) (join-line)))
         ("C-a" . #'mark-whole-buffer)
         ("C-S-b" . #'switch-to-buffer)
         ("C-p" . #'window-toggle-side-windows)
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
         ("C-M-o" . consult-imenu-multi)
         ("C-w" . delete-window)
         ("C-c t e" . eldoc-mode))

  :custom
  (display-line-numbers-type nil)
  (confirm-kill-emacs nil)
  (delete-by-moving-to-trash t)
  (comment-empty-lines t))

(use-package emacs
  :defer t
  :config
;;;###autoload
  (defun aleksei/buffer-file-name-for-frame-title ()
    (let ((doom-modeline-buffer-file-name-style 'relative-to-project))
      (doom-modeline-buffer-file-name)))

  (setq frame-title-format '((:eval (aleksei/buffer-file-name-for-frame-title))
                             (:eval (concat " - " (projectile-project-name))))
        icon-title-format frame-title-format))

(use-package magit
  :defer t
  :bind (:map magit-section-mode-map
         ("C-<tab>" . nil)
         ("<C-iso-lefttab>" . nil)
         :map magit-mode-map
         ("C-w" . #'delete-window)))

(use-package smartparens
  :defer t
  :config
  (defun aleksei/sp-beginning-or-end-of-sexp ()
    "Move to the beginning of sexp if not at the beginning, otherwise move to the end of sexp."
    (interactive)
    (let ((initial-point (point)))
      (sp-beginning-of-sexp)
      (when (eq initial-point (point))
        (sp-end-of-sexp))))
  :custom ((sp-override-key-bindings
            '(("C-<right>" . nil)
              ("C-<left>" . nil)
              ("M-m" . aleksei/sp-beginning-or-end-of-sexp)
              ("C-M-k"  . nil)
              ("C-M-t" . nil)
              ("C-M-e" . nil)))))

;;;###autoload
(defun aleksei/org-gtd ()
  "Prepare Emacs frame to use as a GTD system."
  (interactive)
  (require 'org)
  ;; (dolist (f org-agenda-files)
  ;;   (find-file (concat org-directory "/" f)))
  (find-file (concat org-directory "/tasks.org" ))
  (org-agenda-list))

(use-package org
  :defer t
  :hook ((org-mode . (lambda ()
                       (toggle-truncate-lines -1)
                       (toggle-word-wrap +1)
                       (add-hook! 'before-save-hook :local t #'algus/org-update-parent-todo-statistics))))
  :config
  (defun algus/org-update-parent-todo-statistics ()
    (let ((current-prefix-arg t))
      (call-interactively 'org-update-statistics-cookies)))

  (defun algus/org-todo-convert-to-project ()
    (interactive)
    (save-excursion
      (org-todo "")
      (goto-char (line-beginning-position))
      (if (looking-at "\\(**+\\) ")
          (replace-match "\\1 [/] ")))
    (call-interactively 'org-insert-todo-subheading))

  ;; emacs -f 'aleksei/org-capture' --geometry 100x20+911+645

  (setq org-provide-todo-statistics 'all-headlines
        org-directory "~/org"
        org-tag-alist '(("outside" . ?o)
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
        org-agenda-files '("tasks.org"  "tickler.org" "inbox.org")
        org-refile-targets '((org-agenda-files :maxlevel . 2) (("someday.org") :maxlevel . 1))
        org-archive-location (concat "archive/" (format-time-string "%Y") ".org::")
        org-archive-default-command 'org-archive-subtree
        org-agenda-start-on-weekday 1
        org-agenda-start-day nil
        org-agenda-span 'week
        calendar-week-start-day 1
        org-capture-templates '(("i" "Todo" entry (file "~/org/inbox.org")
                                 "* TODO %?\n:PROPERTIES:\n:Added: %U\n:END:\n%i\n%a"))
        org-log-into-drawer t
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps t)

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
              ("C-c y" . yank-media)))

(use-package org-agenda
  :defer t
  :bind* (:map org-agenda-mode-map
               ("z" . org-agenda-undo)
               ("C-z" . org-agenda-undo)
               ("C-<return>" . org-agenda-todo)))

(use-package org-capture
  :defer t
  :config
  (setq +org-capture-frame-parameters '((name . "doom-capture")
                                        (left . (+ 1142))
                                        (top . (+ 450))
                                        (width . 101)
                                        (height . 25)
                                        (transient . t)
                                        nil)))

(use-package org-modern
  :defer t
  :custom
  (org-modern-todo nil)
  (org-modern-progress nil)
  (org-modern-timestamp nil)
  (org-modern-tag nil))

(use-package ert
  :defer t
  :ensure nil
  :bind (:map emacs-lisp-mode-map
              ("C-; f" . ert)))

(use-package expand-region
  :defer t
  :config
  :bind (("C-h" . er/expand-region)
         ("C-S-h" . (lambda () (interactive) (er/expand-region -1)))))

(use-package crux
  :defer t
  :bind
  (("<home>" . crux-move-beginning-of-line)
   ("C-x 4 t" . crux-transpose-windows)))

(use-package isearch
  :defer t
  :ensure nil
  :config
;;;###autoload
  (defun aleksei/isearch-region-or-forward ()
    "Do incremental search forward, use region if it's active"
    (interactive)
    (if (use-region-p)
        (isearch-forward-thing-at-point)
      (isearch-forward)))

  (remove-hook 'isearch-mode-hook 'isearch-yank-kill)

  (global-anzu-mode +1)

  :bind (("C-f" . #'aleksei/isearch-region-or-forward)
         ("C-r" . #'anzu-query-replace-regexp)
         ("M-f" . #'+default/search-buffer)
         ("C-S-f" . #'+default/search-project)
         ("C-M-<down>" . #'next-error)
         ("C-M-<up>" . (lambda () (interactive) (next-error -1)))
         :map isearch-mode-map
         ("C-f" . #'isearch-repeat-forward)
         ("S-<return>" . #'isearch-repeat-backward)
         ("<return>". #'isearch-repeat-forward)
         ("C-g" . #'isearch-exit)
         ("C-v" . #'isearch-yank-kill)
         :map minibuffer-local-isearch-map
         ("C-f" . #'isearch-forward-exit-minibuffer)
         ("C-r" . #'isearch-backward-exit-minibuffer)
         ("C-v" . #'isearch-yank-kill))

  :custom ((search-exit-option 'edit)
           (select-enable-clipboard t)
           (select-active-regions nil)
           (search-nonincremental-instead nil)))

(use-package winner
  :defer t
  :ensure nil
  :bind (("<f3>" . #'winner-undo)
         ("<f4>" . #'winner-redo)))

(use-package comint
  :defer t
  :bind (:map comint-mode-map
              ("C-d" . comint-delchar-or-maybe-eof)
              ("C-c" . nil)
              ("M-<up>" . comint-previous-prompt)
              ("M-<down>" . comint-next-prompt)))

(use-package python-mode
  :defer t
  :bind (:map python-mode-map
              ("<tab>" . python-indent-shift-right)
              ("<backtab>" . python-indent-shift-left)))

(load! "configs/windows.el")

(use-package rst-mode
  :defer t
  :bind (:map rst-mode-map
              ("<tab>" . indent-rigidly-right)
              ("<backtab>" . indent-rigidly-left)))

(use-package lsp-mode
  :defer t
  :bind (:map lsp-mode-map
              ("M-<RET>" . lsp-execute-code-action)
              ("C-t" . lsp-rename)
              ("C-." . lsp-execute-code-action)
              ("C-S-o" . consult-lsp-file-symbols))

  :config
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'")
  (defun lsp-ui-doc-show-or-focus ()
    "Show hover information popup, focus it if it's already shown"
    (interactive)
    (if (lsp-ui-doc--visible-p)
        (lsp-ui-doc-focus-frame)
      (lsp-ui-doc-glance)))

  :hook (;; (lsp-mode-hook . (lambda ()
         ;;                    (setq-local er/try-expand-list
         ;;                                (append er/try-expand-list '(lsp-extend-selection)))))
         (lsp-ui-mode . (lambda ()
                          (setq lsp-ui-doc-border (modus-themes-get-color-value 'fg-main))
                          (modus-themes-with-colors
                            (custom-set-faces
                             `(lsp-ui-doc-background ((t :background ,bg-dim))))))))
  :custom
  (lsp-ui-sideline-diagnostic-max-lines 10)
  (lsp-ui-sideline-show-diagnostics nil)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-doc-max-height 13)
  (lsp-eslint-experimental-incremental-sync t)
  (lsp-modeline-diagnostics-enable nil)
  (lsp-modeline-workspace-status-enable nil)
  (lsp-lens-enable nil)
  (lsp-eslint-run "onType")
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(file symbols))
  (lsp-headerline-breadcrumb-enable-diagnostics nil)
  (lsp-file-watch-threshold 5000)
  (lsp-enable-symbol-highlighting nil)
  ;; If an LSP server isn't present when I start a prog-mode buffer, you
  ;; don't need to tell me. I know. On some machines I don't care to have
  ;; a whole development environment for some ecosystems.
  (lsp-enable-suggest-server-download nil))

(use-package flymake
  :defer t
  :ensure nil
  :bind (:map flymake-mode-map
              ("<f2>" . #'flymake-goto-next-error)
              ("S-<f2>" . #'flymake-goto-prev-error))
  :hook ((prog-mode text-mode) . flymake-mode)
  :custom (;; (flymake-show-diagnostics-at-end-of-line t)
           flymake-fringe-indicator-position 'right-fringe))

(use-package mocha
  :defer t
  :custom (mocha-reporter "spec"))

(use-package diff-hl
  :defer t
  :bind (:map diff-hl-mode-map
              ("C-M-z" . +vc-gutter/revert-hunk)
              ("M-[" . +vc-gutter/previous-hunk)
              ("M-]" . +vc-gutter/next-hunk)
              ("C-'" . diff-hl-show-hunk)))

(use-package projectile
  :defer t
  :config
  (defun aleksei/compile ()
    "Run compilation command in project root or just in current dir"
    (interactive)
    (if (projectile-project-root)
        (call-interactively 'projectile-compile-project)
      (call-interactively 'compile)))

  (defvar algus/project-list-exclude '(".local\/straight/repos" "dotfiles/doom-emacs")
    "Used by `algus/project-p' to exclude projects")
  
  (defun algus/project-ignored-p (dir)
    "Decides if `DIR' is ignored as a project"
    (seq-some (lambda (r) (string-match-p r dir))
              algus/project-list-exclude))
  
  (defun algus/projectile-project-p (dir)
    "Decides if `DIR' is a project. It is used by projectile"
    (or (doom-project-ignored-p dir)
        (algus/project-ignored-p dir)))

  :custom
  (projectile-ignored-project-function #'algus/projectile-project-p)
  (project-list-exclude '(algus/project-ignored-p))
  (projectile-compile-use-comint-mode t)

  :bind (:map projectile-mode-map
              ("C-S-t" . projectile-toggle-between-implementation-and-test)
              ("C-8" . projectile-run-async-shell-command-in-root)
              ("M-9" . magit-status)
              ("C-e" . consult-projectile)
              ("C-S-r" . projectile-replace)))


(use-package compile
  :defer t
  :ensure nil
  :config
  ;; Add NodeJS error format
  (setq compilation-error-regexp-alist-alist
        (cons '(node "^[  ]+at \\(?:[^(\n]+ (?\\)?\\(?:file://\\)?\\([@a-zA-Z.0-9_/-]+\\):\\([0-9]+\\):\\([0-9]+\\))?$"
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

(use-package vterm
  :defer t
  :bind (:map vterm-mode-map
         ("C-z" . vterm-undo)
         ("C-v" . vterm-yank)
         ("C-<backspace>" . vterm-send-meta-backspace)
         ("C-<delete>" . vterm--self-insert)
         ("C-S-<SPC>" . vterm-copy-mode)
         ("C-w" . nil)
         ("C-p" . nil)
         ("M-i" . nil)
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
  :config
  (add-hook 'vterm-mode-hook 'compilation-shell-minor-mode)
  (add-hook 'vterm-mode-hook #'(lambda () (setq-local cua-mode nil)))
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

(use-package better-jumper
  :defer t
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
          consult-imenu
          consult-line
          consult-line-multi
          aleksei/isearch-region-or-forward
          isearch-forward
          isearch-backward
          flycheck-next-error
          flycheck-previous-error
          org-open-at-point-global))

  (dolist (func aleksei/better-jumper-advice-funcs)
    (eval `(defadvice ,func (before better-jumper activate)
             (when (bound-and-true-p better-jumper-local-mode)
               (better-jumper-set-jump))))))

(use-package shell
  :defer t
  :ensure nil
  :config (setq shell-prompt-pattern "^[^#$%>\n]*[#$%>➜] *"))

(use-package multiple-cursors
  :defer t
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

(use-package ein-notebook
  :defer t
  :bind (:map ein:notebook-mode-map
              ("C-<return>" . ein:worksheet-execute-cell-km)
              ("M-<up>" . ein:worksheet-move-cell-up)
              ("M-<down>" . ein:worksheet-move-cell-down)))

(load! "configs/just-cua")

(use-package undo-fu
  :defer t
  :bind (:map global-map
         ("C-_" . nil)
         ("M-_" . nil )
         :map undo-fu-mode-map
         ("C-z"   . undo-fu-only-undo)
         ("C-S-z" . undo-fu-only-redo)
         ("C-_" . nil)
         ("C-M-_" . nil)))

(use-package consult
  :defer t
  :bind (:map global-map
         ("C-b" . consult-buffer)
         :map minibuffer-local-map
         ("C-f" . consult-history)
         ("C-r" . consult-history)))

(use-package vertico
  :defer t
  :bind (:map minibuffer-local-map
              ("C-s" . nil)
              ("<prior>" . vertico-scroll-down)
              ("<next>" . vertico-scroll-up)
              ("C-j" . vertico-exit-input))
  :custom-face
  ;; Avoid `bold' weight because of nerd-icons
  (vertico-current ((t :inherit highlight :extend t :weight normal))))

(use-package embark
  :defer t
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

(use-package grep
  :ensure nil
  :config
  ;; Modified version adds a nerd icon before each filename
  (defun grep--heading-filter ()
    "Filter function to add headings to output of a grep process."
    (unless grep--heading-state
      (setq grep--heading-state (cons (point-min-marker) nil)))
    (save-excursion
      (let ((limit (car grep--heading-state)))
        ;; Move point to the old limit and update limit marker.
        (move-marker limit (prog1 (pos-bol) (goto-char limit)))
        (while (re-search-forward grep-heading-regexp limit t)
          (unless (get-text-property (point) 'compilation-annotation)
            (let ((heading (match-string-no-properties 1))
                  (start (match-beginning 2))
                  (end (match-end 2)))
              (when start
                (put-text-property start end 'invisible t))
              (when (and heading (not (equal heading (cdr grep--heading-state))))
                (save-excursion
                  (goto-char (pos-bol))
                  (insert-before-markers
                   "\n"
                   (nerd-icons-icon-for-file heading)
                   " "
                   (format grep--heading-format heading)))
                (setf (cdr grep--heading-state) heading))))))))

  :custom
  (grep-use-headings t))

(use-package info
  :defer t
  :ensure nil
  :bind (:map Info-mode-map
              ("M-[" . Info-history-back)
              ("M-]" . Info-history-forward)))

(load! "configs/doom-modeline")

(use-package git-link
  :defer t
  :config
;;;###autoload
  (defun git-link-bitbucket-fsecure (_hostname dirname filename branch commit start end)
    (let* ((remote-info (git-link--parse-remote (git-link--remote-url "origin")))
           (hostname (car remote-info))
           (project-with-repo (cadr remote-info))
           (project (car (split-string project-with-repo "/")))
           (repo (cadr (split-string project-with-repo "/"))))
      (format "https://%s/projects/%s/repos/%s/browse/%s%s"
              hostname
              project
              repo
              filename
              (concat (when branch (format "?at=refs/heads/%s" branch))
                      (when start
                        (if end
                            (format "#%s-%s" start end)
                          (format "#%s" start)))))))

  (add-to-list 'git-link-remote-alist '("advtp-upstream\\|stash.f-secure.com" git-link-bitbucket-fsecure))
  (add-to-list 'git-link-commit-remote-alist '("advtp-upstream\\|stash.f-secure.com" git-link-commit-bitbucket-fsecure)))

(add-to-list 'auto-mode-alist '("Cask$" . emacs-lisp-mode))

(use-package sql
  :defer t
  :custom
  (sql-connection-alist
   '(("local/spaceship:slap"
      (sql-product 'postgres)
      (sql-server "localhost")
      (sql-database "spaceship")
      (sql-user "spaceship")))))


(use-package string-inflection
  :defer t
  :config
;;;###autoload
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
  :bind (("C-M-t" . aleksei/string-inflection-cycle-auto)))

(use-package separedit
  :defer t
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
  :config
  (setq separedit-save-key (kbd "C-s"))
  :custom
  (separedit-default-mode 'sql-mode))

(after! man
  (remove-hook 'Man-mode-hook 'hide-mode-line-mode))

(use-package rustic
  :defer t
  :hook
  ((rustic-mode . (lambda () (require 'rust-compile))))
  :bind (:map rustic-mode-map
              ("M-r" . rustic-cargo-test-rerun)))

(use-package rg
  :defer t
  :custom
  (rg-executable "rg"))

(use-package corfu
  :defer t
  :config
  (remove-hook! corfu-mode '+corfu-mode-unbinds)

  (setq corfu-preview-current nil
        corfu-preselect 'first
        corfu-auto nil)
  ;; (corfu-auto-delay 0.01)

  :bind (:map global-map
         ("C-SPC" . completion-at-point)
         :map corfu-map
         ("<tab>" . corfu-complete)
         ;; ("<home>" . corfu-first)
         ;; ("<end>" . corfu-last)
         ("<prior>" . corfu-scroll-down)
         ("<next>" . corfu-scroll-up)
         ("M-v" . nil)
         ("C-v" . nil)
         ("C-<end>" . nil)
         ("M-<" . nil)
         ("M-n" . nil)
         ("M-p" . nil))

  ;; :hook
  ;; (prog-mode . (lambda () (setq-local corfu-auto t)))
  )

(use-package yaml-mode
  :defer t
  :bind (:map yaml-mode-map
              ("<backspace>" . backward-delete-char-untabify)))

(use-package gptel
  :defer t
  :bind (:map global-map
              ("C-S-q" . gptel-menu)
              ;; :map gptel-mode
              ;; ("C-<return>" . gptel-send)
              )
  :config (setq gptel-model "gpt-4o"))

(use-package docker
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.Dockerfile\\'" . dockerfile-mode)))

(use-package phpunit
  :defer t
  :bind-keymap* ("C-;" . aleksei/phpunit-mode-map)
  :config
  (defvar aleksei/phpunit-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "f") 'phpunit-current-class)
      (define-key map (kbd "c") 'phpunit-current-test)
      (define-key map (kbd "a") 'phpunit-current-project)
      (define-key map (kbd "l") 'recompile)
      map))

  ;; Hacks for Forenom. TODO: Move this to .dir-locals.el
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

  ;; Don't add the bad compilation regexp. I will add my own bad regexps
  (defun phpunit-run (args)
    "Execute phpunit command with `ARGS'."
    ;; (add-to-list 'compilation-error-regexp-alist '("^\\(.+\\.php\\):\\([0-9]+\\)$" 1 2))
    ;; format: #0 /path/to/file(line): class::method(param)
    ;; (add-to-list 'compilation-error-regexp-alist '("^#[0-9]+ \\(.+\\.php\\)(\\([0-9]+\\)):" 1 2))
    (let ((default-directory (phpunit-get-root-directory))
          (compilation-process-setup-function #'phpunit--setup-compilation-buffer))
      (compile (phpunit-get-compile-command args))))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(phpunit  "^[[:blank:]]+[[:digit:].]+.*[[:digit:]]+. .* \\([^[:blank:]]+\\):\\([0-9]+\\)" 1 2))
  (add-to-list 'compilation-error-regexp-alist 'phpunit)

  ;; Add `Warning:' to the default php regexp
  (add-to-list 'compilation-error-regexp-alist-alist
               '(php-warning "\\(?:Warning\\): \\(.*\\) in \\(.*\\) on line \\([0-9]+\\)" 2 3 nil nil))
  (add-to-list 'compilation-error-regexp-alist 'php-warning)

  )

(use-package flyspell
  :defer t
  :ensure nil
  :bind (:map flyspell-mode-map
              ("C-;" . nil)))

(use-package apheleia
  :defer t
  :config
  (add-to-list 'apheleia-mode-alist '(nxml-mode . yq-xml)))

(use-package treesit
  :defer t
  :ensure nil
  :custom
  (treesit-font-lock-level 4))

(use-package treesit-auto
  :defer t
  :ensure nil
  :config
  (global-treesit-auto-mode +1))

(use-package bookmark
  :defer t
  :ensure nil
  :custom
  (bookmark-watch-bookmark-file 'silent))

(use-package iflipb
  :defer t
  :bind (("C-<tab>" . 'iflipb-next-buffer)
         ("C-<iso-lefttab>" . 'iflipb-previous-buffer))
  :custom
  (iflipb-wrap-around t)
  (iflipb-ignore-buffers '()))

(use-package consult-projectile
  :defer t
  :custom
  (consult-projectile-sources '(consult--source-buffer
                                consult-projectile--source-projectile-file)))

(use-package desktop
  :defer nil

  :config
  ;; Save Doom's lookup variables. Otherwise they are uninitialized after
  ;; desktop is restored
  (let ((lookup-types '(definition
                        implementations
                        type-definition
                        references
                        documentation
                        file
                        xref-backend)))
    (dolist (type lookup-types)
      (add-to-list 'desktop-locals-to-save (intern (format "+lookup-%s-functions" type)))))

  ;; (add-hook! 'doom-after-init-hook :append
  ;;   (when (doom-project-p)
  ;;     (desktop-read ".")
  ;;     (desktop-save-mode +1)))

  :custom
  (desktop-path . ("."))
  (desktop-save t))

(add-hook! typescript-ts-mode-local-vars :append #'+javascript-init-lsp-or-tide-maybe-h)

(use-package emacs
  :defer t
  :ensure nil
  :config
;;;###autoload
  (defun algus/javascript-console-dir ()
    "Add console.dir calls one line above with the current region as the param."
    (interactive)
    (when (use-region-p)
      (let ((region-text (buffer-substring-no-properties (region-beginning) (region-end))))
        (save-excursion
          (goto-char (region-beginning))
          (forward-line -1)
          (end-of-line)
          (insert
           "\n\n// TODO: Remove me!\n"
           "console.dir(\n"
           region-text
           "\n);\n")))))

  (map! :map (typescript-ts-mode-map typescript-mode-map rjsx-mode-map)
        "C-c C-d"
        #'algus/javascript-console-dir))

(load! "configs/eshell.el")

(load! "configs/too-wide-minibuffer-mode.el")
(use-package too-wide-minibuffer-mode
  :config
  (defun algus/remove-fringe-from-minibuffer (&rest _)
    (set-window-fringes (minibuffer-window) 0))
  (too-wide-minibuffer-mode +1)

  :hook
  ((minibuffer-setup window-state-change) . algus/remove-fringe-from-minibuffer))

(use-package hardhat
  :config
  (defun algus/disable-checks-if-read-only ()
    (when (or buffer-read-only hardhat-mode)
      (eldoc-mode -1)
      (flyspell-mode -1)
      (flymake-mode -1)))

  (global-hardhat-mode +1)
  :custom
  (hardhat-fullpath-protected-regexps '("~/src/dotfiles/doom-emacs/"
                                        "/share/emacs/30\\.1/lisp/"))
  :hook
  ((find-file hardhat-mode) . algus/disable-checks-if-read-only))

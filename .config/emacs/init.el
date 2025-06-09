;;; init.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: April 09, 2025
;; Modified: April 09, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/hron/dotfiles/.config/emacs
;; Package-Requires: ((emacs "29.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aleksei Gusev"
      user-mail-address "aleksei.gusev@gmail.com")

(add-to-list 'load-path (locate-user-emacs-file "lisp"))

(use-package emacs
  :init
  (cua-mode +1)
  :custom
  (cua-remap-control-z nil)
  (cua-prefix-override-inhibit-delay 0.0000000001)
  (cua-rectangle-mark-key [(control shift return)]))

;;;###autoload
(defun aleksei/save-all-buffers ()
  "Save all modified buffers, literally (save-some-buffers +1)."
  (interactive)
  (save-some-buffers +1))

;;;###autoload
(defun aleksei/comment-dwim (&optional arg)
  "My replacement for `comment-dwim' (ARG is passed through).

If no region is selected and point is not at the end of the line,
comment or uncomment the current line. Otherwise, call `comment-dwim'."
  (interactive "*P")
  (if (and (not (use-region-p))
           (not (and (looking-back "^[[:blank:]]*") (looking-at "[[:blank:]]*$"))))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position) arg)
    (comment-dwim arg)))

(defun aleksei/format-region-or-buffer ()
  "Format region or buffer."
  (interactive)
  (call-interactively #'apheleia-format-buffer))

;;;###autoload
(defun aleksei/eldoc ()
  "Run eldoc and switch to its buffer it is executed second time."
  (interactive)
  (if-let* ((eldoc-window (eq last-command 'aleksei/eldoc))
            (eldoc-window (get-buffer-window-list "*eldoc*")))
      (select-window (car eldoc-window))
    (call-interactively 'eldoc)))

(use-package emacs
  :bind (("C-<f2>" . #'list-processes)
         ("C-d" . #'duplicate-dwim)
         ("C-s" . #'aleksei/save-all-buffers)
         ("<f6>" . #'toggle-truncate-lines)
         ("C-S-j" . (lambda () (interactive) (forward-line) (join-line)))
         ("C-a" . #'mark-whole-buffer)
         ("C-S-b" . #'switch-to-buffer)
         ("C-/" . #'aleksei/comment-dwim)
         ("C-M-l" . #'aleksei/format-region-or-buffer)
         ("M-C-." . #'eglot-find-typeDefinition)
         ("C->" . #'eglot-find-implementation)
         ("M-." . #'xref-find-definitions)
         ("M->" . #'xref-find-references)
         ("S-RET" . #'flymake-show-project-diagnostics)
         ("C-c t e" . #'eldoc-mode)
         ("C-z" . #'undo-only)
         ("C-S-z" . #'undo-redo)
         ("C-q" . #'aleksei/eldoc))
  :custom
  (display-line-numbers-type nil)
  (confirm-kill-emacs nil)
  (delete-by-moving-to-trash t)
  (comment-empty-lines t)
  (dired-listing-switches "-alh --group-directories-first")
  (create-lockfiles nil)
  (make-backup-files nil)
  (indent-tabs-mode nil)
  (vc-follow-symlinks t)
  :hook (before-save . whitespace-cleanup))

(setq-default cursor-type '(bar . 5))
(setq w32-pass-lwindow-to-system nil
      w32-pass-rwindow-to-system nil)
(modify-all-frames-parameters
 '((font . "JetBrainsMono Nerd Font-10")))
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode (frame-char-width))
(global-auto-revert-mode +1)
(global-subword-mode +1)
(blink-cursor-mode +1)
(context-menu-mode +1)
(pixel-scroll-precision-mode +1)
(global-hl-line-mode +1)
(savehist-mode +1)
;; (save-place-mode +1)
(recentf-mode +1)

(setq frame-title-format '("%b" (:eval (concat " - " (project-name (project-current)))))
      icon-title-format frame-title-format)

(use-package bookmark
  :ensure nil
  :custom
  (bookmark-watch-bookmark-file 'silent))



(defun aleksei/eldoc-display-in-buffer (docs interactive)
  "Display DOCS in a dedicated buffer only if INTERACTIVE is t."
  (when interactive
    (eldoc--format-doc-buffer docs)
    (eldoc-doc-buffer t)))
(use-package eldoc
  :config
  (setq eldoc-display-functions '(eldoc-display-in-echo-area aleksei/eldoc-display-in-buffer)))

(use-package iflipb
  :defer t
  :bind (("C-<tab>" . 'iflipb-next-buffer)
         ("C-<iso-lefttab>" . 'iflipb-previous-buffer))
  :custom
  (iflipb-wrap-around t)
  (iflipb-ignore-buffers '()))

(use-package drag-stuff
  :bind (("M-<up>" . nil)
         ("M-<down>" . nil)
         ("M-S-<up>" . #'drag-stuff-up)
         ("M-S-<down>" . #'drag-stuff-down)))


(push 'comint straight-built-in-pseudo-packages)
(use-package comint
  :ensure nil
  :bind (("M-t" . #'project-compile)
         ("M-r" . #'recompile)
         :map comint-mode-map
         ("C-d" . comint-delchar-or-maybe-eof)
         ("C-c" . nil)
         ("M-<up>" . comint-previous-prompt)
         ("M-<down>" . comint-next-prompt)))



(use-package compile
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
        (cons 'webpack-ts-error compilation-error-regexp-alist))

  (add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)
  :custom
  (compilation-always-kill t)
  (compilation-ask-about-save nil)
  (compilation-scroll-output 'first-error))

(use-package winner
  :ensure nil
  :bind (("<f5>" . (lambda () (interactive) (funcall-interactively 'jump-to-register ?w)))
         ("C-<f5>" . (lambda ()
                       (interactive)
                       (funcall-interactively 'window-configuration-to-register ?w)
                       (message "Window configuration is saved in ‘w’ register. Restore it with <f5>.")))
         ("<f3>" . #'winner-undo)
         ("<f4>" . #'winner-redo))
  :init
  (winner-mode +1))

(push 'isearch straight-built-in-pseudo-packages)
(use-package isearch
  :ensure nil
  :config
  (remove-hook 'isearch-mode-hook 'isearch-yank-kill)

  :bind (("C-f" . #'isearch-forward)
         ("M-f" . #'isearch-forward-thing-at-point)
         ("C-M-<down>" . #'next-error)
         ("C-M-<up>" . (lambda () (interactive) (next-error -1)))
         :map isearch-mode-map
         ("C-f" . #'isearch-repeat-forward)
         ("S-<return>" . #'isearch-repeat-backward)
         ("<return>". #'isearch-repeat-forward)
         ("C-g" . #'isearch-exit)
         ("C-v" . #'isearch-yank-kill)
         ("C-r" . #'isearch-query-replace)
         ("M-C-r" . #'isearch-query-replace-regexp)
         ("C-<home>" . #'isearch-beginning-of-buffer)
         ("C-<end>" . #'isearch-end-of-buffer)
         :map minibuffer-local-isearch-map
         ("C-f" . #'isearch-forward-exit-minibuffer)
         ("C-r" . #'isearch-backward-exit-minibuffer)
         ("C-v" . #'isearch-yank-kill))

  :custom ((search-exit-option 'edit)
           (select-enable-clipboard t)
           (select-active-regions nil)
           (search-nonincremental-instead nil)))

;;;###autoload
(defun aleksei/anzu-query-replace-at-cursor ()
  "Run `anzu-query-replace' for (thing-at-point 'symbol)."
  (interactive)
  (let ((query-replace-history query-replace-history))
    (add-to-history 'query-replace-history (thing-at-point 'symbol))
    (call-interactively 'anzu-query-replace-at-cursor)))

;;;###autoload
(defun aleksei/anzu-query-replace ()
  "Run `anzu-query-replace' for with region if it's not multiline."
  (interactive)
  (if (and (use-region-p)
           (= (line-number-at-pos (region-beginning))
              (line-number-at-pos (region-end))))
      (let ((isearch-string (buffer-substring-no-properties (region-beginning) (region-end))))
        (deactivate-mark)
        (anzu--query-replace-common nil :isearch-p t)))
  (call-interactively #'anzu-query-replace))

(use-package anzu
  :commands (aleksei/anzu-query-replace-at-cursor
             aleksei/anzu-query-replace
             anzu-query-replace-at-cursor
             isearch-forward
             isearch-forward-thing-at-point)
  :init
  (global-anzu-mode +1)

  :bind
  (("C-t" . #'aleksei/anzu-query-replace-at-cursor)
   ("C-r" . #'aleksei/anzu-query-replace)
   ("C-M-r" . #'anzu-query-replace-regexp)
   :map isearch-mode-map
   ("C-r" . #'anzu-isearch-query-replace)
   ("M-C-r" . #'anzu-isearch-query-replace-regexp)
   ("M-%" . #'anzu-isearch-query-replace)
   ("M-C-%" . #'anzu-isearch-query-replace-regexp)))

(use-package consult
  :bind (("C-S-f" . #'consult-ripgrep)
         ("C-b" . #'consult-buffer)
         ("C-S-o" . #'consult-imenu)
         ("M-o" . #'consult-imenu-multi)
         ("S-RET" . #'consult-flymake)
         ("C-e" . #'aleksei/consult-project)
         :map minibuffer-local-map
         ("C-f" . #'consult-history)
         ("C-r" . #'consult-history))
  :init
  (setq xref-show-xrefs-function       #'consult-xref
        xref-show-definitions-function #'consult-xref))

(defvar aleksei/consult-source-not-opened-project-file
  (list :name     "Project File"
        :narrow   '(?f . "File")
        :category 'file
        :face     'consult-file
        :history  'file-name-history
        :action   (lambda (f) (consult--file-action (concat (project-root (project-current)) f)))
        :enabled  #'project-current
        :items
        (lambda ()
          (let* ((project-root (project-root (project-current)))
                 (project-files-relative-names t)
                 (project-files (project-files (project-current))))
            (cl-remove-if
             (lambda (file)
               (get-file-buffer (expand-file-name file project-root)))
             project-files)))))

;;;###autoload
(defun aleksei/consult-project ()
  "Switch to a buffer, a bookmark or find project file."
  (interactive)
  (require 'consult)
  (consult--multi '(consult--source-buffer
                    consult--source-bookmark
                    aleksei/consult-source-not-opened-project-file)
                  :prompt "Switch to: "
                  :history 'consult-projectile--project-history
                  :sort nil))

(use-package marginalia
  :bind (:map minibuffer-mode-map
              ("M-a" . #'marginalia-cycle))
  :init
  (marginalia-mode +1))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :init (vertico-mode +1)
  :bind (:map minibuffer-local-map
              ("C-s" . nil)
              ("<prior>" . vertico-scroll-down)
              ("<next>" . vertico-scroll-up)
              ("C-j" . vertico-exit-input))
  :config
  (setq vertico-buffer-display-action '(display-buffer-below-selected (side . bottom)))
  ;; (vertico-buffer-mode +1)
  :custom-face
  ;; Avoid `bold' weight because of nerd-icons
  (vertico-current ((t :inherit highlight :extend t :weight normal))))

(use-package embark
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

(use-package embark-consult)

(use-package corfu
  :custom
  (corfu-preview-current nil)
  (corfu-preselect 'first)
  (corfu-auto nil)
  (global-corfu-minibuffer t)
  :bind (:map global-map
              ("C-SPC" . #'completion-at-point)
              :map corfu-map
              ("RET" . nil)
              ("<tab>" . #'corfu-complete)
              ;; ("<home>" . #'corfu-first)
              ;; ("<end>" . #'corfu-last)
              ("<prior>" . #'corfu-scroll-down)
              ("<next>" . #'corfu-scroll-up)
              ("M-v" . nil)
              ("C-v" . nil)
              ("C-<end>" . nil)
              ("M-<" . nil)
              ("M-n" . nil)
              ("M-p" . nil))
  :hook
  (prog-mode . (lambda () (setq-local corfu-auto t)))
  :init
  (global-corfu-mode +1))

(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  ;; (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
  )

(use-package doom-modeline
  :init (doom-modeline-mode +1)
  :hook (doom-modeline-mode . size-indication-mode) ; filesize in modeline
  :hook (doom-modeline-mode . column-number-mode)   ; cursor column in modeline
  :custom
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-buffer-file-name-style 'auto)
  (doom-modeline-height (+ (frame-char-height) 8)))

(use-package gptel
  :bind (:map global-map
              ("C-<return>" . gptel-menu)
              ;; :map gptel-mode
              ;; ("C-<return>" . gptel-send)
              )
  :config (setq gptel-model "gpt-4o"))

(use-package magit
  :bind (("M-9" . magit-status)
         :map magit-section-mode-map
         ("C-<tab>" . nil)
         ("<C-iso-lefttab>" . nil)
         :map magit-mode-map
         ("C-w" . delete-window))
  :hook (magit-post-refresh . diff-hl-magit-post-refresh))

(use-package diff-hl
  :init (global-diff-hl-mode +1)
  :bind (:map diff-hl-mode-map
              ("C-M-z" . #'diff-hl-revert-hunk)
              ("M-[" . #'diff-hl-previous-hunk)
              ("M-]" . #'diff-hl-next-hunk)
              ("C-'" . diff-hl-show-hunk)))

;; emacs-lisp-mode
(use-package emacs
  :bind (:map emacs-lisp-mode-map
              ("C-q" . describe-symbol))
  :hook ((emacs-lisp-mode . (lambda () (setq tab-width 2)))))

(use-package ert
  :bind (:map emacs-lisp-mode-map
              ("C-; f" . ert)))

(use-package expand-region
  :bind (("C-h" . er/expand-region)
         ("C-S-h" . er/contract-region)))

(use-package crux
  :bind (("<home>" . crux-move-beginning-of-line)))

(defun aleksei/remove-fringe-from-minibuffer (&rest _)
  "Remove fringes in minibuffer window."
  (set-window-fringes (minibuffer-window) 0))

(use-package too-wide-minibuffer-mode
  :init
  (too-wide-minibuffer-mode +1)
  :custom
  (minibuffer-follows-selected-frame nil)
  :hook
  ((minibuffer-setup window-state-change) . aleksei/remove-fringe-from-minibuffer))

(use-package grep
  :custom
  (grep-use-headings t)
  :bind (:map grep-mode-map
              ("C-S-o" . consult-outline)))

(use-package nerd-icons)
(use-package nerd-icons-completion
  :init (nerd-icons-completion-mode +1))
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-corfu
  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))
(use-package nerd-icons-grep
  :straight (nerd-icons-grep :type git :host github :repo "hron/nerd-icons-grep")
  :init (nerd-icons-grep-mode +1))

(push 'treesit straight-built-in-pseudo-packages)
(use-package treesit
  :ensure nil
  :custom
  (treesit-font-lock-level 4))
(use-package treesit-auto
  :defer nil
  :init
  (require 'treesit-auto)
  (treesit-auto-add-to-auto-mode-alist
   ;; all except rust
   '(awk bash bibtex blueprint c c-sharp clojure cmake commonlisp cpp css
         dart dockerfile elixir glsl go gomod heex html janet java
         javascript json julia kotlin latex lua magik make markdown nix nu
         org perl proto python r ruby scala sql surface toml tsx
         typescript typst verilog vhdl vue wast wat wgsl yaml))
  :custom
  (treesit-auto-install nil))

(use-package better-jumper
  :bind (("M-<left>" . better-jumper-jump-backward)
         ("M-<right>" . better-jumper-jump-forward))
  :config
  (let ((funcs '(beginning-of-buffer
                 end-of-buffer
                 mark-whole-buffer
                 imenu
                 consult-lsp-symbols
                 consult-imenu
                 consult-line
                 consult-line-multi
                 consult-ripgrep
                 consult-grep
                 aleksei/isearch-region-or-forward
                 isearch-forward
                 isearch-backward
                 query-replace
                 anzu-query-replace-at-cursor
                 aleksei/anzu-query-replace-at-cursor
                 aleksei/anzu-query-replace
                 flycheck-next-error
                 flycheck-previous-error
                 flycheck-goto-next-error
                 flycheck-goto-prev-error
                 org-open-at-point-global
                 xref-find-definitions
                 xref-find-references
                 eglot-find-typeDefinition
                 eglot-find-implementation
                 diff-hl-next-hunk
                 diff-hl-previous-hunk
                 expand-region
                 aleksei/sp-beginning-or-end-of-sexp)))
    (dolist (func funcs)
      (eval `(defadvice ,func (before better-jumper activate)
               (when (bound-and-true-p better-jumper-local-mode)
                 (better-jumper-set-jump))))))
  :init
  (better-jumper-mode +1))

(use-package apheleia
  :init
  (apheleia-global-mode +1)
  :config
  (add-to-list 'apheleia-mode-alist '(nxml-mode . yq-xml)))

(use-package shell
  :ensure nil
  :config (setq shell-prompt-pattern "^[^#$%>\n]*[#$%>➜] *"))

(use-package multiple-cursors
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

(push 'flymake straight-built-in-pseudo-packages)
(use-package flymake
  :ensure nil
  :bind (("C-c t f" . #'flymake-mode)
         :map flymake-mode-map
         ("<f2>" . #'flymake-goto-next-error)
         ("S-<f2>" . #'flymake-goto-prev-error))
  :hook ((prog-mode text-mode) . flymake-mode)
  :custom (;; (flymake-show-diagnostics-at-end-of-line t)
           flymake-fringe-indicator-position 'right-fringe))

(use-package server
  :when (display-graphic-p)
  :defer 1
  :config
  (when-let (name (getenv "EMACS_SERVER_NAME"))
    (setq server-name name))
  (unless (server-running-p)
    (server-start)))

(use-package desktop
  :init
  (dolist (frame-param '(background-color foreground-color background-mode))
    (push (cons frame-param :never) frameset-filter-alist))
  (desktop-save-mode +1)
  :custom
  (desktop-path (list "."))
  (desktop-save t))

(use-package emacs
  :init
  (electric-pair-mode +1)
  (electric-quote-mode +1)
  (electric-indent-mode +1)
  (electric-layout-mode +1))

(defun aleksei-toggle-flyspell-mode ()
  (interactive)
  (if flyspell-mode
      (progn
        (call-interactively '(lambda () (interactive) (flyspell-mode -1))))
    (call-interactively (if (derived-mode-p 'prog-mode) #'flyspell-prog-mode #'flyspell-mode))))

(use-package flyspell
  :bind (("C-c t s" . #'aleksei-toggle-flyspell-mode)
         :map flyspell-mode-map
         ("C-;" . nil))
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))
(use-package emacs
  :custom
  (ispell-silently-savep t))

(use-package hardhat
  :config
  (defun aleksei/disable-checks-if-read-only ()
    (when (or buffer-read-only hardhat-mode)
      (eldoc-mode -1)
      (flyspell-mode -1)
      (flymake-mode -1)))

  (global-hardhat-mode +1)
  :custom
  (hardhat-fullpath-protected-regexps '("~/src/dotfiles/doom-emacs/"
                                        "/straight/repos/"
                                        "/share/emacs/.*/lisp/"))
  :hook
  ((find-file hardhat-mode) . aleksei/disable-checks-if-read-only))

(use-package smartparens
  :init
  (require 'smartparens)
;;;###autoload
  (defun aleksei/sp-beginning-or-end-of-sexp ()
    "Move to the beginning or to the end of sexp."
    (interactive)
    (let ((initial-point (point)))
      (sp-beginning-of-sexp)
      (when (eq initial-point (point))
        (sp-end-of-sexp))))

  :bind
  (("M-m" . #'aleksei/sp-beginning-or-end-of-sexp))
  :custom
  (sp-override-key-bindings
   '(("C-<right>" . nil)
     ("C-<left>" . nil)
     ("M-m" . aleksei/sp-beginning-or-end-of-sexp)
     ("C-M-k"  . nil)
     ("C-M-t" . nil)
     ("C-M-e" . nil))))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package debian-el)

(push 'eglot straight-built-in-pseudo-packages)
(use-package eglot
  :hook ((rust-ts-mode rust-mode) . #'eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-t" . #'eglot-rename)
              ("C-." . #'eglot-code-actions)))

(use-package edit-indirect)
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do))
  :custom
  (markdown-fontify-code-blocks-natively t))

(use-package dumb-jump
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(defvar aleksei-rust-dbg-compilation-regexp
  '("\\[\\([^:]+\\):\\([0-9]+\\):\\([0-9]+\\)\\]" 1 2 3 0)
  "Specifications for matching dbg! output.")

(use-package rust-mode
  :straight (rust-mode :type git :host github :repo "rust-lang/rust-mode"
                       :method fetch-from-remote
                       :fork "hron" :branch "rust-compilation-dbg!")
  :init
  (setq rust-load-optional-libraries nil
        rust-mode-treesitter-derive t)
  (require 'rust-cargo)
  (require 'rust-compile)
  ;; (require 'rust-playpen)
  ;; (require 'rust-rustfmt)
  ;; (add-to-list 'compilation-error-regexp-alist-alist
  ;;              (cons 'rustc-dbg! aleksei-rust-dbg-compilation-regexp))
  ;; (add-to-list 'compilation-error-regexp-alist 'rustc-dbg!)
  )

(use-package gcmh
  :init (gcmh-mode +1))

(require 'aleksei-org)
(require 'aleksei-windows)
(require 'aleksei-vterm)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-directories '("/home/algus/src/zed/")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((t :extend nil))))

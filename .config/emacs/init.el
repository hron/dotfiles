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
;; Package-Requires: ((emacs "30.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(add-to-list 'load-path (locate-user-emacs-file "lisp"))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aleksei Gusev"
      user-mail-address "aleksei.gusev@gmail.com")

(define-key key-translation-map (kbd "C-c") (kbd "C-b"))
(define-key key-translation-map (kbd "C-b") (kbd "C-c"))
(keyboard-translate ?\C-d ?\C-x)
(keyboard-translate ?\C-x ?\C-d)

;;;###autoload
(defun init-save-all-buffers ()
  "Save all modified buffers, literally (save-some-buffers +1)."
  (interactive)
  (save-some-buffers +1))

;;;###autoload
(defun init-comment-dwim (&optional arg)
  "My replacement for `comment-dwim' (ARG is passed through).

If no region is selected and point is not at the end of the line,
comment or uncomment the current line.  Otherwise, call `comment-dwim'."
  (interactive "*P")
  (if (and (not (use-region-p))
           (not (and (looking-back "^[[:blank:]]*") (looking-at "[[:blank:]]*$"))))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position) arg)
    (comment-dwim arg)))

(defun init-format-region-or-buffer ()
  "Format region or buffer."
  (interactive)
  (call-interactively #'apheleia-format-buffer))

;;;###autoload
(defun init-eldoc ()
  "Run eldoc and switch to its buffer it is executed second time."
  (interactive)
  (if-let* ((eldoc-window (eq last-command 'init-eldoc))
            (eldoc-window (get-buffer-window-list "*eldoc*")))
      (select-window (car eldoc-window))
    (call-interactively 'eldoc)))

(defun init-copy-line-or-region ()
  "Copy region if active, otherwise copy current line."
  (interactive)
  (let ((bounds (if (use-region-p)
                    (list (region-beginning) (region-end))
                  (list (line-beginning-position)
                        (line-beginning-position 2)))))
    (apply #'pulse-momentary-highlight-region bounds)
    (apply #'kill-ring-save bounds)))

;; Enhanced cut function
(defun init-cut-line-or-region ()
  "Cut region if active, otherwise cut current line."
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-region (line-beginning-position)
                 (line-beginning-position 2))))

(use-package emacs
  :bind (("C-<f2>" . #'list-processes)
         ("M-d" . #'duplicate-dwim)
         ("C-s" . #'init-save-all-buffers)
         ("<f6>" . #'toggle-truncate-lines)
         ("C-S-j" . (lambda () (interactive) (forward-line) (join-line)))
         ("C-a" . #'mark-whole-buffer)
         ("C-S-b" . #'switch-to-buffer)
         ("C-/" . #'init-comment-dwim)
         ("C-M-l" . #'init-format-region-or-buffer)
         ("M-C-." . #'eglot-find-typeDefinition)
         ("C->" . #'eglot-find-implementation)
         ("M-." . #'xref-find-definitions)
         ("M->" . #'xref-find-references)
         ("S-RET" . #'flymake-show-project-diagnostics)
         ("C-c t e" . #'eldoc-mode)
         ("C-z" . #'undo-only)
         ("C-S-z" . #'undo-redo)
         ("<f1> '" . #'describe-char)
         ("C-q" . #'init-eldoc)
         ("C-M-o" . #'consult-eglot-symbols)
         ("C-M-r" . #'revert-buffer)
         ("M-v" . #'yank-from-kill-ring)
         ("M-y" . #'completion-at-point)
         ("C-k" . nil)
         ("C-b" . #'init-copy-line-or-region)
         ("C-d" . #'init-cut-line-or-region)
         ("C-v" . #'yank))
  :config
  (advice-add 'duplicate-dwim :after #'deactivate-mark)
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
  (project-vc-ignores '("straight/repos"))
  (find-function-C-source-directory "~/src/emacs/src")
  (tab-always-indent t)
  (undo-limit 1600000)
  (woman-fill-column 100)
  :hook (before-save . whitespace-cleanup))

(if (eq system-type 'windows-nt)
    (setq-default cursor-type '(bar . 5))
  (setq-default cursor-type 'bar))
(when (eq system-type 'windows-nt)
  (setq w32-pass-lwindow-to-system t
        w32-pass-rwindow-to-system t)
  (global-set-key (kbd "M-<f4>") #'save-buffers-kill-terminal))
;; (if (eq system-type 'windows-nt)
;;     (modify-all-frames-parameters
;;      '((font . "JetBrains Mono SemiBold-10")))
;;   (modify-all-frames-parameters
;;    '((font . "JetBrains Mono-10:weight=regular"))))
(modify-all-frames-parameters
 '((font . "JetBrains Mono-10:weight=regular")))
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(if (eq system-type 'windows-nt)
    (fringe-mode 12)
  (fringe-mode 8))
(global-auto-revert-mode +1)
(global-subword-mode +1)
(which-key-mode +1)
(blink-cursor-mode +1)
(context-menu-mode +1)
(pixel-scroll-precision-mode +1)
(global-hl-line-mode +1)
(savehist-mode +1)
;; (save-place-mode +1)
(recentf-mode +1)
(minibuffer-depth-indicate-mode +1)
(delete-selection-mode +1)

(defun init-desktop-base-dirname ()
  "Return base directory with desktop file for modeline."
  (if-let* ((dir (file-name-nondirectory (directory-file-name desktop-dirname))))
      (concat " / " dir)
    ""))

(setq frame-title-format
      '("%b" (:eval (concat " - " (project-name (project-current)) (init-desktop-base-dirname))))
      icon-title-format frame-title-format)

(setq-default tab-width 4)

(use-package bookmark
  :ensure nil
  :custom
  (bookmark-watch-bookmark-file 'silent))

(defun init-eldoc-display-in-buffer (docs interactive)
  "Display DOCS in a dedicated buffer only if INTERACTIVE is t."
  (when interactive
    (eldoc--format-doc-buffer docs)
    (eldoc-doc-buffer t)))
(use-package eldoc
  :config
  (setq eldoc-display-functions '(eldoc-display-in-echo-area init-eldoc-display-in-buffer)))

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


;;;###autoload
(defun init-project-compile ()
  "Run `compile' in the project root."
  (interactive)
  (call-interactively (if (project-current) #'project-compile #'compile)))

(push 'comint straight-built-in-pseudo-packages)
(use-package comint
  :ensure nil
  :bind (("M-t" . #'init-project-compile)
         ("M-r" . #'recompile)
         :map comint-mode-map
         ("C-x" . comint-delchar-or-maybe-eof)
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
  (compilation-scroll-output 'first-error)
  (compile-command ""))

(use-package compile-plus
  :ensure t
  :straight (compile-plus :type git :host github :repo "hron/compile-plus")
  :init (compile-plus-mode +1))

(use-package dock
  :if (featurep 'dbus)
  :ensure t
  :init
  (require 'dock)
  (add-hook 'compilation-finish-functions (lambda (_buf _msg) (dock-set-needs-attention)))
  (dock-track-urgency-mode +1))

(use-package winner
  :ensure nil
  :bind (("<f5>" . (lambda () (interactive) (funcall-interactively 'jump-to-register ?w)))
         ("C-<f5>" . (lambda ()
                       (interactive)
                       (funcall-interactively 'window-configuration-to-register ?w)
                       (message "Window configuration is saved in  w  register. Restore it with <f5>.")))
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
         ("M-w" . #'isearch-query-replace)
         ("M-C-r" . #'isearch-query-replace-regexp)
         ("C-<home>" . #'isearch-beginning-of-buffer)
         ("C-<end>" . #'isearch-end-of-buffer)
         :map minibuffer-local-isearch-map
         ("C-f" . #'isearch-forward-exit-minibuffer)
         ("C-r" . #'isearch-backward-exit-minibuffer)
         ("C-v" . #'isearch-yank-kill))

  :custom ((search-exit-option 'edit)
           (select-enable-clipboard t)
           (select-enable-primary t)
           (select-active-regions nil)
           (search-nonincremental-instead nil)))

;;;###autoload
(defun init-anzu-query-replace-at-cursor ()
  "Run `anzu-query-replace' for (thing-at-point 'symbol)."
  (interactive)
  (let ((query-replace-history query-replace-history))
    (add-to-history 'query-replace-history (thing-at-point 'symbol))
    (call-interactively 'anzu-query-replace-at-cursor)))

;;;###autoload
(defun init-anzu-query-replace ()
  "Run `anzu-query-replace' for with region if it's not multiline."
  (interactive)
  (if (and (use-region-p)
           (= (line-number-at-pos (region-beginning))
              (line-number-at-pos (region-end))))
      (let ((isearch-string (buffer-substring-no-properties (region-beginning) (region-end))))
        (goto-char (region-beginning))
        (deactivate-mark)
        (anzu--query-replace-common nil :isearch-p t)))
  (call-interactively #'anzu-query-replace))

(use-package anzu
  :commands (init-anzu-query-replace-at-cursor
             init-anzu-query-replace
             anzu-query-replace-at-cursor
             isearch-forward
             isearch-forward-thing-at-point)
  :init
  (global-anzu-mode +1)

  :bind
  (("C-t" . #'init-anzu-query-replace-at-cursor)
   ("M-w" . #'init-anzu-query-replace)
   ("C-M-w" . #'anzu-query-replace-regexp)
   :map isearch-mode-map
   ("M-w" . #'anzu-isearch-query-replace)
   ("M-C-w" . #'anzu-isearch-query-replace-regexp)
   ("M-%" . #'anzu-isearch-query-replace)
   ("M-C-%" . #'anzu-isearch-query-replace-regexp)))

(defun init-bounds-of-region-or-symbol-at-point ()
  "Return string of region if it's active otherwise symbols' at point."
  (let ((bounds (if (use-region-p)
                    (car (region-bounds))
                  (bounds-of-thing-at-point 'symbol))))
    (buffer-substring-no-properties (car bounds) (cdr bounds))))

(defun init-consult-rigrep-thing-at-point ()
  "Search the project for the thing at point of region."
  (interactive)
  (funcall-interactively #'consult-ripgrep nil (init-bounds-of-region-or-symbol-at-point)))

(use-package consult
  :bind (("C-S-f" . #'consult-ripgrep)
         ("M-F" . #'init-consult-rigrep-thing-at-point)
         ("C-S-o" . #'consult-imenu)
         ("M-o" . #'consult-imenu-multi)
         ("S-RET" . #'consult-flymake)
         ("C-e" . #'init-consult-project)
         ("M-g M-g" . #'consult-goto-line)
         ("M-g e" . #'consult-compile-error)
         :map minibuffer-local-map
         ("C-f" . #'consult-history)
         ("C-r" . #'consult-history))
  :init
  (setq xref-show-xrefs-function       #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :custom
  (completion-in-region-function #'consult-completion-in-region))

(use-package emacs
  :init (global-completion-preview-mode +1)
  :bind (:map completion-preview-active-mode-map
              ("C-i" . nil)
              ("M-i" . nil)
              ("C-y" . #'completion-preview-complete)
              ("C-/" . #'completion-preview-insert)
              ("M-n" . #'completion-preview-next-candidate)
              ("M-p" . #'completion-preview-prev-candidate)))

(defvar init-consult-source-not-opened-project-file
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
(defun init-consult-project ()
  "Switch to a buffer, a bookmark or find project file."
  (interactive)
  (require 'consult)
  (consult--multi '(consult--source-buffer
                    consult--source-bookmark
                    init-consult-source-not-opened-project-file)
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
  (completion-styles '(orderless))
  (completion-ignore-case t))

(use-package vertico
  :init
  (vertico-mode +1)

  (defun init-fix-vertico-faces (&optional _theme)
    "Avoid `bold' weight because of nerd-icons"
    (set-face-attribute 'vertico-current nil :weight 'normal))
  (init-fix-vertico-faces)
  (add-hook 'enable-theme-functions #'init-fix-vertico-faces)

  :bind (:map minibuffer-local-map
              ("C-s" . nil)
              ("<prior>" . vertico-scroll-down)
              ("<next>" . vertico-scroll-up)
              ("C-j" . vertico-exit-input)
              ("TAB" . nil)
              ("C-y" . #'vertico-insert)
              :map minibuffer-local-shell-command-map
              ("TAB" . nil))
  :config
  (setq vertico-buffer-display-action '(display-buffer-below-selected (side . bottom))))

(use-package embark
  :bind (:map global-map
              ("M-<return>" . embark-act)
              ("C-;" . nil)
              :map minibuffer-local-map
              ("M-<return>" . embark-act)
              :map minibuffer-mode-map
              ("M-<return>" . embark-act)
              :map embark-region-map
              ("+" . #'gptel-add))
  :custom
  (embark-indicators '(embark--vertico-indicator
                       embark-highlight-indicator
                       embark-isearch-highlight-indicator))
  (embark-prompter 'embark-completing-read-prompter))

(use-package embark-consult)

(use-package cape
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-history))

(use-package doom-modeline
  :init
  (column-number-mode +1)
  (doom-modeline-mode +1)

  (defun init-fix-doom-modeline-faces (&optional _theme)
    "Remove bold faces to avoid conflict with nerd-icons"
    (let ((bold-faces '(doom-modeline-urgent
                        doom-modeline-warning
                        doom-modeline-info
                        doom-modeline-lsp-success
                        doom-modeline-lsp-error
                        doom-modeline-lsp-warning)))
      (dolist (f bold-faces)
        (set-face-attribute f nil :weight 'normal))))
  (init-fix-doom-modeline-faces)
  (add-hook 'enable-theme-functions #'init-fix-doom-modeline-faces)

  :custom
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-buffer-file-name-style 'auto)
  (doom-modeline-height (+ (frame-char-height) 4)))

(use-package gptel
  :bind (("C-c C-<return>" . gptel-menu)
         ("C-c <return>" . gptel-send)
         ("C-c j" . gptel-menu)
         ("C-c J" . gptel)
         ("C-c C-g" . gptel-abort)
         :map gptel-mode-map
         ("C-c C-x t" . gptel-set-topic))
  :config
  (defvar init-gptel-gemini
    (gptel-make-gemini "Gemini" :stream t :key gptel-api-key))
  (defvar init-gptel-anthropic
    (gptel-make-anthropic "Claude" :key gptel-api-key :stream t))
  (defvar init-gptel-perplexity
    (gptel-make-perplexity "Perplexity" :key gptel-api-key :stream t))
  (setq-default gptel-backend init-gptel-gemini
                gptel-model 'gemini-2.5-flash)
  :custom
  (gptel-default-mode #'org-mode)
  (gptel-include-reasoning nil)
  (gptel-track-media t)
  (gptel-rewrite-default-action 'accept)
  :commands (gptel gptel-send))

(use-package magit
  :bind (("M-9" . magit-status)
         :map magit-section-mode-map
         ("C-<tab>" . nil)
         ("<C-iso-lefttab>" . nil)
         :map magit-mode-map
         ("C-j" . nil)
         ("C-w" . delete-window)
         :map magit-hunk-section-map
         ("C-j" . nil)
         :map magit-diff-section-map
         ("C-j" . nil))
  :hook (magit-post-refresh . diff-hl-magit-post-refresh)
  :custom
  (transient-display-buffer-action '(display-buffer-in-direction
                                     (window . main)
                                     (direction . below)
                                     (dedicated . t)
                                     (inhibit-same-window . t)))
  (git-commit-summary-max-length 50))

(use-package diff-hl
  :init (global-diff-hl-mode +1)
  :bind (:map diff-hl-mode-map
              ("C-M-z" . #'diff-hl-revert-hunk)
              ("M-[" . #'diff-hl-previous-hunk)
              ("M-]" . #'diff-hl-next-hunk)
              ("C-'" . #'diff-hl-show-hunk)))

;; emacs-lisp-mode
(use-package emacs
  :bind (:map emacs-lisp-mode-map
              ("C-q" . describe-symbol)
              :map lisp-interaction-mode-map
              ("C-j" . nil))
  :hook ((emacs-lisp-mode . (lambda () (setq tab-width 2)))))

(push 'autoinsert straight-built-in-pseudo-packages)
(use-package autoinsert
  :init (auto-insert-mode +1)
  :config
  (add-to-list
   'auto-insert-alist
   `(("\\.el\\'" . "Emacs Lisp header")
     "Short description: "
     ";;; " (file-name-nondirectory (buffer-file-name)) " --- " str
     (make-string (max 2 (- 80 (current-column) 27)) ?\s)
     "-*- lexical-binding: t; -*-" '(setq lexical-binding t)
     ";;
;;
;; Copyright (C) " (format-time-string "%Y") "  "
     (getenv "ORGANIZATION") | (progn user-full-name) "
;;
;; Author: " (user-full-name)
     '(if (search-backward "&" (line-beginning-position) t)
          (replace-match (capitalize (user-login-name)) t t))
     '(end-of-line 1) " <" (progn user-mail-address) ">
;; Keywords: "
     '(require 'finder)
     ;;'(setq v1 (apply 'vector (mapcar 'car finder-known-keywords)))
     '(setq v1 (mapcar ,(lambda (x) (list (symbol-name (car x))))
                       finder-known-keywords)
            v2 (mapconcat (lambda (x) (format "%12s:  %s" (car x) (cdr x)))
                          finder-known-keywords
                          "\n"))
     ((let ((minibuffer-help-form v2))
        (completing-read "Keyword, C-h: " v1 nil t))
      str ", ")
     & -2 "
\;; SPDX-License-Identifier: GPL
\;;
\;;; Commentary:
\;;
\;; " _ "
\;;
\;;; Code:



\(provide '"
     (file-name-base (buffer-file-name))
     ")
\;;; " (file-name-nondirectory (buffer-file-name)) " ends here\n")))

(use-package ert
  :bind (:map emacs-lisp-mode-map
              ("C-; f" . ert)))

(use-package expand-region
  :bind (("C-h" . er/expand-region)
         ("C-S-h" . er/contract-region)))

(use-package crux
  :bind (("<home>" . crux-move-beginning-of-line)))

(defun init-remove-fringe-from-minibuffer (&rest _)
  "Remove fringes in minibuffer window."
  (set-window-fringes (minibuffer-window) 0))

(use-package too-wide-minibuffer-mode
  :init
  (too-wide-minibuffer-mode +1)
  :custom
  (minibuffer-follows-selected-frame nil)
  :hook
  ((minibuffer-setup window-state-change) . init-remove-fringe-from-minibuffer))

(use-package grep
  :custom
  (grep-use-headings t)
  :bind (:map grep-mode-map
              ("C-S-o" . consult-outline)))

(use-package nerd-icons
  ;; :custom
  ;; (nerd-icons-font-family "JetBrainsMono Nerd Font")
  )

(use-package nerd-icons-completion
  :init (nerd-icons-completion-mode +1))
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-grep
  :straight (nerd-icons-grep :type git :host github :repo "hron/nerd-icons-grep")
  :init (nerd-icons-grep-mode +1))
(use-package nerd-icons-xref
  :straight (nerd-icons-xref :type git :host github :repo "hron/nerd-icons-xref")
  :init (nerd-icons-xref-mode +1))

(use-package treesit-auto
  :defer nil
  :if (not (eq system-type 'windows-nt))
  :init
  (require 'treesit-auto)
  (require 'yaml-ts-mode)
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
                 consult-imenu-multi
                 init-isearch-region-or-forward
                 isearch-forward
                 isearch-backward
                 query-replace
                 anzu-query-replace-at-cursor
                 init-anzu-query-replace-at-cursor
                 init-anzu-query-replace
                 flycheck-next-error
                 flycheck-previous-error
                 flycheck-goto-next-error
                 flycheck-goto-prev-error
                 flymake-goto-next-error
                 flymake-goto-prev-error
                 next-error
                 org-open-at-point-global
                 xref-find-definitions
                 xref-find-references
                 eglot-find-typeDefinition
                 eglot-find-implementation
                 diff-hl-next-hunk
                 diff-hl-previous-hunk
                 expand-region
                 init-puni-matchit
                 puni-forward-sexp
                 puni-backward-sexp
                 puni-beginning-of-sexp
                 puni-end-of-sexp
                 puni-syntactic-forward-punct
                 puni-syntactic-backward-punct
                 project-query-replace-regexp)))
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
  :config (setq shell-prompt-pattern "^[^#$%>\n]*[#$%> ] *"))

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

  (require 'desktop)
  (when (file-exists-p (desktop-full-file-name "."))
    (desktop-save-mode +1))

  :custom
  (desktop-path (list "."))
  (desktop-save t)
  (desktop-globals-to-save '(desktop-missing-file-warning
                             tags-file-name
                             tags-table-list
                             search-ring
                             regexp-search-ring
                             register-alist
                             file-name-history
                             compile-history)))

(use-package emacs
  :init
  (electric-pair-mode +1)
  (electric-indent-mode +1)
  (electric-layout-mode +1))

(defun init-toggle-flyspell-mode ()
  (interactive)
  (if flyspell-mode
      (progn
        (call-interactively '(lambda () (interactive) (flyspell-mode -1))))
    (call-interactively (if (derived-mode-p 'prog-mode) #'flyspell-prog-mode #'flyspell-mode))))

(use-package flyspell
  :bind (("C-c t s" . #'init-toggle-flyspell-mode)
         :map flyspell-mode-map
         ("C-;" . nil))
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))
(use-package emacs
  :custom
  (ispell-silently-savep t))

(use-package hardhat
  :config
  (defun init-disable-checks-if-read-only ()
    (when (or buffer-read-only hardhat-mode)
      (eldoc-mode -1)
      (flyspell-mode -1)
      (flymake-mode -1)))

  (global-hardhat-mode +1)
  :custom
  (hardhat-fullpath-protected-regexps '("~/src/dotfiles/doom-emacs/"
                                        "/straight/repos/"
                                        "/share/emacs/.*/lisp/"
                                        "/.cargo/registry/"))
  :hook
  ((find-file hardhat-mode) . init-disable-checks-if-read-only))

;;;###autoload
(defun init-puni-matchit ()
  "Jump between open and close parentheses."
  (interactive)
  (let ((travel-func (if (not (puni-strict-backward-sexp)) #'puni-strict-forward-sexp #'puni-strict-backward-sexp)))
    (while (funcall travel-func))))

(use-package puni
  :defer nil
  :init (puni-global-mode +1)
  :bind (("M-m" . nil)
         :map puni-mode-map
         ("M-m" . #'init-puni-matchit)
         ("DEL" . nil)
         ("C-x" . nil)
         ("M-d" . nil)
         ("M-DEL" . nil)
         ("C-k" . nil)
         ("C-S-k" . nil)
         ("C-c DEL" . nil)
         ("C-w" . nil)
         ("C-d" . nil)))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package debian-el)

(defun init-manually-activate-imenu ()
  "Activate imenu manually in eglot."
  (when (not (derived-mode-p 'rust-mode))
    (add-function :before-until (local 'imenu-create-index-function)
                  #'eglot-imenu)))

(push 'eglot straight-built-in-pseudo-packages)
(use-package eglot
  :hook ((rust-ts-mode rust-mode python-mode python-ts-mode) . #'eglot-ensure)
  :hook (eglot-managed-mode-hook . (lambda () (eglot-inlay-hints-mode -1)))
  :hook (eglot-managed-mode-hook . init-manually-activate-imenu)
  :config
  (add-to-list 'eglot-stay-out-of 'imenu)
  (setq eglot-events-buffer-config  '(:size 0 :format 'full))
  :bind (:map eglot-mode-map
              ("C-t" . #'eglot-rename)
              ("C-." . #'eglot-code-actions)
              ("C-M-o". #'consult-eglot-symbols))
  :custom-face (eglot-diagnostic-tag-unnecessary-face ((t :inherit nil))))

(push 'project straight-built-in-pseudo-packages)
(use-package consult-eglot)

(use-package edit-indirect)
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do))
  :hook (gfm-mode . (lambda () (toggle-word-wrap +1)))
  :custom
  (markdown-fontify-code-blocks-natively t))

(use-package dumb-jump
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package rust-mode
  ;; :straight (rust-mode :type git :host github :repo "rust-lang/rust-mode"
  ;;                      :method fetch-from-remote
  ;;                      :fork "hron" :branch "rust-compilation-dbg!")
  :init
  (setq rust-load-optional-libraries nil
        rust-mode-treesitter-derive (not (eq system-type 'windows-nt)))
  ;; (require 'rust-cargo)
  (require 'rust-compile)
  ;; (require 'rust-playpen)
  ;; (require 'rust-rustfmt)
  :bind (:map rust-mode-map
              ("C-M-q" . nil))
  :custom
  (rust-ts-flymake-command '("cargo" "clippy")))

(unless (featurep 'mps)
  (use-package gcmh
    :init (gcmh-mode +1)))

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package fish-mode)

(use-package string-inflection
  :bind (("M-c" . #'string-inflection-all-cycle)))

(use-package package-lint-flymake
  :hook (emacs-lisp-mode . package-lint-flymake-setup))

(use-package devdocs
  :bind (("C-M-q" . devdocs-search)))

(use-package python
  :config
  ;; python.el modifies them after loading, so we have to fix it here
  (add-to-list 'auto-mode-alist '("\\.py[iw]?\\'" . python-ts-mode))
  (add-to-list 'interpreter-mode-alist '("python[0-9.]*" . python-ts-mode))
  :bind (:map python-ts-mode-map
              ("C-M-q" . nil)))

(use-package qml-mode)

(use-package gnus
  :config
  (setq gnus-select-method '(nntp "news.gmane.io"))
  :custom
  (gnus-always-read-dribble-file t))

(use-package telega
  :custom
  (telega-server-libs-prefix "/usr"))

;; (use-package dape
;;   :hook
;;   (kill-emacs . dape-breakpoint-save)
;;   (after-init . dape-breakpoint-load)
;;   :config
;;   (dape-breakpoint-global-mode)
;;   :custom
;;   (dape-key-prefix "\C-x\C-a"))

;; Enable repeat mode for more ergonomic `dape' use
(use-package repeat
  :config
  (repeat-mode))

(use-package just-ts-mode)

(use-package emacs
  :hook (yaml-ts-mode . (lambda () (setq-default tab-width 2))))

(require 'init-windows)
(require 'init-org)
(unless (eq system-type 'windows-nt)
  (require 'init-vterm))

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-directories
   '("/home/algus/src/rune/" "/home/algus/src/melpa/"
     "/home/algus/.emacs.d/straight/build/magit/"
     "/home/algus/src/dotfiles/.config/emacs/straight/repos/magit/"
     "/home/algus/src/zed/"))
 '(safe-local-variable-values
   '((lsp-enabled-clients jsts-ls)
     (eval setq-local flymake-diagnostic-functions
           (cl-remove 'package-lint-flymake
                      flymake-diagnostic-functions :test 'eq))
     (checkdoc-allow-quoting-nil-and-t . t)
     (flymake-clippy-bin-args "--tests" "--workspace" "--" "-D"
                              "warnings"))))
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)

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

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(use-package emacs
  :ensure nil
  :init
  (cua-mode +1)
  :custom
  (cua-remap-control-z nil)
  (cua-prefix-override-inhibit-delay nil)
  (cua-rectangle-mark-key [(control shift return)])
  :bind (("C-z" . #'undo-only)
         ("C-S-z" . #'undo-redo)))

;; (use-package benchmark-init
;;   :pin "melpa"
;;   :config
;;   (add-hook 'after-init-hook #'benchmark-init/deactivate))

(use-package auto-dark
  :pin "melpa"
  :init
  (auto-dark-mode +1)
  :custom
  (auto-dark-themes '((modus-vivendi) (modus-operandi)))
  :unless noninteractive)

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

(use-package emacs
  :ensure nil
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
         ("<f1> '" . #'describe-char)
         ("C-q" . #'init-eldoc)
         ("C-M-o" . #'consult-eglot-symbols)
         ("C-M-r" . #'revert-buffer)
         ("M-C-v" . #'yank-from-kill-ring)
         ("C-k" . nil)
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
  (find-function-C-source-directory "~/src/emacs/src")
  (tab-always-indent 'complete)
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
(fringe-mode 10)
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
      (concat " || " dir)
    ""))

(setq frame-title-format
      '("%b"
        (:eval (when (project-current) (format  " - %s" (project-name (project-current)))))
        (:eval (if-let* ((dir desktop-dirname)
                         (dir (file-name-nondirectory (directory-file-name dir))))
                   (concat " ┃ " dir)
                 "")))
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
  :ensure nil
  :config
  (setq eldoc-display-functions '(eldoc-display-in-echo-area init-eldoc-display-in-buffer)))

(use-package move-text
  :pin "melpa"
  :bind
  ("M-S-<up>" . #'move-text-up)
  ("M-S-<down>" . #'move-text-down))

;;;###autoload
(defun init-project-compile ()
  "Run `compile' in the project root."
  (interactive)
  (call-interactively (if (project-current) #'project-compile #'compile)))

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

;; (use-package compile-plus
;;   :ensure t
;;   :straight (compile-plus :type git :host github :repo "hron/compile-plus")
;;   :init (compile-plus-mode +1))

(use-package dock
  :pin "melpa"
  :if (featurep 'dbus)
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

(defun init-consult-imenu-multi (arg)
  "Select item from the imenus of all buffers.
Filter by current project if ARG is supplied."
  (interactive "P")
  (let ((query (if arg nil (list :sort 'alpha))))
    (funcall-interactively #'consult-imenu-multi query)))

(use-package consult
  :pin "melpa"
  :bind (("C-S-f" . #'consult-ripgrep)
         ("M-F" . #'init-consult-rigrep-thing-at-point)
         ("C-S-o" . #'consult-imenu)
         ("M-o" . #'init-consult-imenu-multi)
         ("S-RET" . #'consult-flymake)
         ("C-e" . #'init-consult-project)
         ("M-g M-g" . #'consult-goto-line)
         ("M-g e" . #'consult-compile-error)
         :map minibuffer-local-map
         ("C-r" . #'consult-history))
  :init
  (setq xref-show-xrefs-function       #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :custom
  (completion-in-region-function #'consult-completion-in-region))

(use-package emacs
  :ensure nil
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
  :pin "melpa"
  :bind (:map minibuffer-mode-map
              ("M-a" . #'marginalia-cycle))
  :init
  (marginalia-mode +1))

(use-package orderless
  :pin "melpa"
  :custom
  (completion-styles '(orderless))
  (completion-ignore-case t))

(use-package vertico
  :pin "melpa"
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
              ("C-y" . #'vertico-insert))
  :config
  (setq vertico-buffer-display-action '(display-buffer-below-selected (side . bottom))))

(use-package embark
  :pin "melpa"
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

(use-package embark-consult
  :pin "melpa")

(use-package corfu
  :pin "melpa"
  :custom
  (corfu-preview-current nil)
  (corfu-preselect 'first)
  (global-corfu-minibuffer t)
  :bind (:map corfu-map
              ("TAB" . #'corfu-complete)
              ("C-y" . #'corfu-expand)
              ("<prior>" . #'corfu-scroll-down)
              ("<next>" . #'corfu-scroll-up)
              ("<home>" . #'corfu-first)
              ("<end>" . #'corfu-last))
  :init
  (global-corfu-mode +1)
  (corfu-popupinfo-mode +1)
  (corfu-history-mode +1))

(use-package cape
  :pin "melpa"
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-history))

(use-package doom-modeline
  :pin "melpa"
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
  :pin "melpa"
  :bind (("C-k C-<return>" . #'gptel-send)
         ("C-k <return>" . #'gptel-menu)
         ("C-k C-g" . #'gptel-abort)
         ("C-k k" . #'gptel)
         :map gptel-mode-map
         ("C-c C-c" . #'gptel-send)
         ("C-c C-x t" . #'gptel-set-topic))
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
  :pin "melpa"
  :init (global-diff-hl-mode +1)
  :bind (:map diff-hl-mode-map
              ("C-M-z" . #'diff-hl-revert-hunk)
              ("M-[" . #'diff-hl-previous-hunk)
              ("M-]" . #'diff-hl-next-hunk)
              ("C-'" . #'diff-hl-show-hunk)))

;; emacs-lisp-mode
(use-package emacs
  :ensure nil
  :bind (:map emacs-lisp-mode-map
              ("C-q" . describe-symbol)
              :map lisp-interaction-mode-map
              ("C-q" . describe-symbol))
  :hook ((emacs-lisp-mode . (lambda () (setq tab-width 8)))))

(use-package autoinsert
  :ensure nil
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

(use-package expand-region
  :pin "melpa"
  :bind (("C-h" . er/expand-region)
         ("C-S-h" . er/contract-region)))

(use-package crux
  :bind (("<home>" . crux-move-beginning-of-line)))

(defun init-remove-fringe-from-minibuffer (&rest _)
  "Remove fringes in minibuffer window."
  (set-window-fringes (minibuffer-window) 0))

(use-package too-wide-minibuffer-mode
  :pin "melpa"
  :init
  (too-wide-minibuffer-mode +1)
  :custom
  (minibuffer-follows-selected-frame nil)
  :hook
  ((minibuffer-setup window-state-change) . init-remove-fringe-from-minibuffer))

(use-package grep
  :ensure nil
  :custom
  (grep-use-headings t)
  :bind (:map grep-mode-map
              ("C-S-o" . consult-outline)))

(use-package nerd-icons
  :pin "melpa")

(use-package nerd-icons-completion
  :pin "melpa"
  :init (nerd-icons-completion-mode +1))
(use-package nerd-icons-dired
  :pin "melpa"
  :hook
  (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-corfu
  :pin "melpa"
  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))
(use-package nerd-icons-grep
  :pin "melpa"
  ;; :ensure (nerd-icons-grep :type git :host github :repo "hron/nerd-icons-grep")
  :init (nerd-icons-grep-mode +1))
(use-package nerd-icons-xref
  :pin "melpa"
  ;; :ensure (nerd-icons-xref :type git :host github :repo "hron/nerd-icons-xref")
  :init (nerd-icons-xref-mode +1))

(use-package lua-ts-mode
  :ensure nil  ; Built into Emacs 31+
  :mode "\\.lua\\'"
  :init
  (require 'treesit)
  (treesit-ensure-installed 'lua))

(use-package better-jumper
  :preface
  (defun init-beginning-of-defun ()
    "Set better-jumper jump and call \\[beginning-of-defun].
It seems `beginning-of-defun' is used internally by
\\[xref-find-definitions], so when it's advices with
`better-jumper-set-jump' the better jumper ring becomes broken."
    (interactive)
    (better-jumper-set-jump)
    (call-interactively #'beginning-of-defun))

  (defun init-end-of-defun ()
    "Set better-jumper jump and call \\[end-of-defun].
It seems `end-of-defun' is used internally by
\\[xref-find-definitions], so when it's advices with
`better-jumper-set-jump' the better jumper ring becomes broken."
    (interactive)
    (better-jumper-set-jump)
    (call-interactively #'end-of-defun))

  :bind
  ("M-<left>" . better-jumper-jump-backward)
  ("M-<right>" . better-jumper-jump-forward)
  ("C-M-<home>" . #'init-beginning-of-defun)
  ("C-M-<end>" . #'init-end-of-defun)

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
                 project-query-replace-regexp
                 compilation-next-error
                 compilation-previous-error)))
    (dolist (func funcs)
      (eval `(defadvice ,func (before better-jumper activate)
               (when (bound-and-true-p better-jumper-local-mode)
                 (better-jumper-set-jump))))))
  :init
  (better-jumper-mode +1))

(use-package apheleia
  :pin "melpa"
  :init
  (apheleia-global-mode +1)
  :config
  (add-to-list 'apheleia-mode-alist '(nxml-mode . yq-xml)))

(use-package shell
  :ensure nil
  :config (setq shell-prompt-pattern "^[^#$%>\n]*[#$%> ] *"))

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
  :ensure nil
  :when (display-graphic-p)
  :defer 1
  :config
  (when-let (name (getenv "EMACS_SERVER_NAME"))
    (setq server-name name))
  (unless (server-running-p)
    (server-start)))

(use-package desktop
  :ensure nil
  :init
  (dolist (frame-param '(background-color foreground-color background-mode))
    (push (cons frame-param :never) frameset-filter-alist))

  :hook
  (after-init
   . (lambda ()
       (when (and (file-exists-p (desktop-full-file-name ".")))
         (desktop-read)
         (desktop-save-mode +1))))

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
  :ensure nil
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
  :ensure nil
  :bind (("C-c t s" . #'init-toggle-flyspell-mode)
         :map flyspell-mode-map
         ("C-;" . nil))
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))

(use-package emacs
  :ensure nil
  :custom
  (ispell-silently-savep t))

(use-package hardhat
  :pin "melpa"
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
                                        "/elpaca/repos/"
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
  :pin "melpa"
  :defer nil
  :init (puni-global-mode +1)
  :bind (("M-m" . nil)
         :map puni-mode-map
         ("M-m" . #'init-puni-matchit)
         ("DEL" . nil)
         ("C-x" . nil)
         ("M-d" . nil)
         ("C-d" . nil)
         ("M-DEL" . nil)
         ("C-k" . nil)
         ("C-S-k" . nil)
         ("C-c DEL" . nil)
         ("C-w" . nil)))

(use-package envrc
  :pin "melpa"
  :hook (after-init . envrc-global-mode))

(defun init-manually-activate-imenu ()
  "Activate imenu manually in eglot."
  (when (not (derived-mode-p 'rust-mode))
    (add-function :before-until (local 'imenu-create-index-function)
                  #'eglot-imenu)))

(use-package eglot
  :ensure nil
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

(use-package consult-eglot
  :pin "melpa")

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
  :pin "melpa"
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package rust-mode
  ;; :ensure (rust-mode :type git :host github :repo "rust-lang/rust-mode"
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
  :pin "melpa"
  :mode "\\.nix\\'")

(use-package fish-mode
  :pin "melpa")

(use-package string-inflection
  :pin "melpa"
  :bind (("M-c" . #'string-inflection-all-cycle)))

(use-package package-lint-flymake
  :pin "melpa"
  :hook (emacs-lisp-mode . package-lint-flymake-setup))

(use-package python
  :ensure nil
  :init
  ;; python.el modifies them after loading, so we have to fix it here
  (add-to-list 'auto-mode-alist '("\\.py[iw]?\\'" . python-ts-mode))
  (add-to-list 'interpreter-mode-alist '("python[0-9.]*" . python-ts-mode))
  :bind (:map python-ts-mode-map
              ("C-M-q" . nil)))

(use-package gnus
  :ensure nil
  :config
  (setq gnus-select-method '(nntp "news.gmane.io"))
  :custom
  (gnus-always-read-dribble-file t))

(use-package dape
  :pin "gnu"
  :hook
  (kill-emacs . dape-breakpoint-save)
  (after-init . dape-breakpoint-load)
  :config
  (dape-breakpoint-global-mode)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  :custom
  (dape-key-prefix "\C-k\C-l")
  (dape-info-hide-mode-line nil)
  (dape-info-buffer-window-groups
   '((dape-info-scope-mode dape-info-watch-mode dape-info-stack-mode dape-info-modules-mode dape-info-sources-mode dape-info-breakpoints-mode dape-info-threads-mode)))
  :bind (:map dape-repl-mode-map
              ("TAB" . #'completion-at-point)))

;; Enable repeat mode for more ergonomic `dape' use
(use-package repeat
  :ensure nil
  :config
  (repeat-mode))

(use-package emacs
  :ensure nil
  :hook (yaml-ts-mode . (lambda () (setq-default tab-width 2))))

(use-package eask-mode
  :pin "melpa")

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
 '(auto-dark-themes '((modus-vivendi) (modus-operandi)) nil nil "Customized with use-package auto-dark")
 '(modus-themes-bold-constructs t)
 '(modus-themes-common-palette-overrides '((bg-region bg-ochre) (fg-region unspecified)))
 '(modus-themes-italic-constructs t)
 '(package-selected-packages
   '(anzu apheleia auto-dark benchmark-init better-jumper cape
          consult-eglot corfu crux dape diff-hl doom-modeline
          dumb-jump eask-mode edit-indirect embark-consult envrc
          expand-region fish-mode gptel hardhat magit marginalia
          markdown-mode move-text nerd-icons-completion
          nerd-icons-corfu nerd-icons-dired nerd-icons-grep
          nerd-icons-xref nix-ts-mode orderless org-agenda-dock
          org-modern org-roam package-lint-flymake puni rust-mode
          string-inflection too-wide-minibuffer-mode vertico vterm))
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
(put 'list-timers 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((t :extend nil))))

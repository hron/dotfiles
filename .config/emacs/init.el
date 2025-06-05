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
  "Replacement for `comment-dwim'.
 If no region is selected and point is not at the end of the line,
 comment or uncomment the current line. Otherwise, call `comment-dwim'."
  (interactive "*P")
  (if (and (not (use-region-p))
           (not (and (looking-back "^[[:blank:]]*") (looking-at "[[:blank:]]*$"))))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(use-package emacs
  :bind (("C-<f2>" . #'list-processes)
         ("C-d" . #'duplicate-dwim)
         ("C-s" . #'aleksei/save-all-buffers)
         ("<f6>" . #'toggle-truncate-lines)
         ("C-j" . (lambda () (interactive) (forward-line) (join-line)))
         ("C-S-j" . (lambda () (interactive) (forward-line) (join-line)))
         ("C-a" . #'mark-whole-buffer)
         ("C-S-b" . #'switch-to-buffer)
         ("C-p" . #'window-toggle-side-windows)
         ("C-/" . #'aleksei/comment-dwim)
         ;; ("C-M-l" . #'+format/region-or-buffer)
         ("M-C-." . #'eglot-find-typeDefinition)
         ("C->" . #'eglot-find-implementation)
         ("M-." . #'xref-find-definitions)
         ("M->" . #'xref-find-references)
         ;; ("C-q" . #'+lookup/documentation)
         ("S-RET" . #'flymake-show-project-diagnostics)
         ("C-S-o" . #'imenu)
         ("C-w" . #'delete-window)
         ("C-c t e" . #'eldoc-mode)
         ("C-z" . #'undo-only)
         ("C-S-z" . #'undo-redo))
  :custom
  (display-line-numbers-type nil)
  (confirm-kill-emacs nil)
  (delete-by-moving-to-trash t)
  (comment-empty-lines t))

(setq-default cursor-type '(bar . 3))
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
(setq frame-title-format '("%b" (:eval (concat " - " (project-name (project-current)))))
      icon-title-format frame-title-format)

(use-package bookmark
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

(use-package drag-stuff
  :bind (("M-<up>" . nil)
         ("M-<down>" . nil)
         ("M-S-<up>" . #'drag-stuff-up)
         ("M-S-<down>" . #'drag-stuff-down)))


(push 'comint straight-built-in-pseudo-packages)
(use-package comint
  :ensure nil
  :defer t
  ;; :commands (comint-run compile)
  :bind (("M-t" . #'project-compile)
         ("M-r" . #'recompile)
         :map comint-mode-map
         ("C-d" . comint-delchar-or-maybe-eof)
         ("C-c" . nil)
         ("M-<up>" . comint-previous-prompt)
         ("M-<down>" . comint-next-prompt)))

(use-package winner
  :ensure nil
  :bind (("<f3>" . #'winner-undo)
         ("<f4>" . #'winner-redo)))


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
         ("C-M-o" . #'consult-imenu-multi)
         ("S-RET" . #'consult-flymake)
         ("C-e" . #'aleksei/consult-project)
         :map minibuffer-local-map
         ("C-f" . #'consult-history)
         ("C-r" . #'consult-history)))

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

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :hook (doom-modeline-mode . size-indication-mode) ; filesize in modeline
  :hook (doom-modeline-mode . column-number-mode)   ; cursor column in modeline
  :config
  (setq doom-modeline-major-mode-icon t
        doom-modeline-buffer-file-name-style 'file-name
        doom-modeline-height (+ (frame-char-height) 8)))

(use-package gptel
  :bind (:map global-map
              ("C-<return>" . gptel-menu)
              ;; :map gptel-mode
              ;; ("C-<return>" . gptel-send)
              )
  :config (setq gptel-model "gpt-4o"))

(use-package magit
  :bind (:map magit-section-mode-map
         ("C-<tab>" . nil)
         ("<C-iso-lefttab>" . nil)
         :map magit-mode-map
         ("C-w" . delete-window)))

(use-package diff-hl
  :init (diff-hl-mode +1)
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
  :config
  (too-wide-minibuffer-mode +1)
  :custom
  (minibuffer-follows-selected-frame nil)
  :hook
  ((minibuffer-setup window-state-change) . aleksei/remove-fringe-from-minibuffer))

;; (use-package nerd-icons-grep)

(require 'algus-org)

(provide 'init)
;;; init.el ends here

(cua-mode +1)
;; (global-undo-tree-mode +1)
;; (define-key cua--cua-keys-keymap [(control z)] 'undo-tree-undo)
;; (define-key cua--cua-keys-keymap [(control shift z)] 'undo-tree-redo)

(global-set-key (kbd "M-<down>") 'other-window)
(global-unset-key (kbd "C-x O"))
(global-set-key (kbd "M-<up>") (lambda () (interactive) (other-window -1)))

(global-set-key (kbd "<escape>") 'keyboard-quit)

(use-package evil
  :bind (("M-[" . evil-jump-backward)
         ("M-]" . evil-jump-forward)))

(use-package helm
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
         :map helm-find-files-map
         ("C-z" . undo-tree-undo)

         ))

(use-package expand-region
  :init
  (global-set-key (kbd "C-h") 'er/expand-region)
  (global-set-key (kbd "C-S-h") (lambda () (interactive) (er/expand-region -1))))

(global-set-key (kbd "<home>") 'mwim-beginning-of-code-or-line)
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
(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "M-.") 'spacemacs/jump-to-definition)))

(use-package undo-tree
  :bind (:map undo-tree-map
              ("C-/" . nil)
              ("C-S-z" . undo-tree-redo)))

(use-package company
  :bind (:map company-mode-map
              ("<escape>" . company-abort)))

(global-set-key [f6] 'toggle-truncate-lines)
(use-package winner
  :init
  (global-set-key [f2] 'winner-undo)
  (global-set-key [f3] 'winner-redo))

(global-set-key (kbd "C-j") '(lambda () (interactive) (next-line) (join-line)))
(global-set-key (kbd "C-S-j") '(lambda () (interactive) (next-line) (join-line)))
(global-set-key (kbd "C-d") 'spacemacs/duplicate-line-or-region)

(global-set-key (kbd "C-w") 'kill-this-buffer)

(use-package comint
  :bind (:map comint-mode-map
              ("C-d" . comint-delchar-or-maybe-eof)
              ("C-c" . nil)))

(use-package org
  :bind (:map org-mode-map
              ("S-<return>" . org-insert-heading-after-current)
              ("S-M-<return>" . org-insert-todo-heading-respect-content)
              ("S-M-<up>" . org-move-subtree-up)
              ("S-M-<down>" . org-move-subtree-down)
              ("C-c o" . gusev/org-todo-convert-to-project)
              ("C-c C-x g" . org-caldav-sync)
              ("C-c b" . org-switchb)
              ("M-<return>" . nil)))

(use-package org-agenda
  :bind* (:map org-agenda-mode-map
              ("z" . org-agenda-undo)))
;; (use-package org-agenda
;;   )
(use-package helm-files
  :config
  (unbind-key "C-<backspace>" helm-find-files-map)
  (unbind-key "C-<backspace>" helm-read-file-map))

(defun gusev--spacemacs|define-jump-handlers (mode &rest handlers)
  "Adds M-. as an alias for SPC m g g"
  (let ((mode-hook (intern (format "%S-hook" mode))))
    (message (format "%S" mode-hook))
    (add-hook mode-hook '(lambda () (local-set-key (kbd "M-.") 'spacemacs/jump-to-definition)))))
(advice-add 'spacemacs|define-jump-handlers :after 'gusev--spacemacs|define-jump-handlers)

(use-package robe
  :bind* (:map robe-mode-map
               ("M-." . spacemacs/jump-to-definition)))
(use-package elisp-slime-nav
  :bind* (:map elisp-slime-nav-mode-map
               ("M-." . spacemacs/jump-to-definition)))
(use-package anaconda-mode
  :bind (:map anaconda-mode-map
              ("M-." . spacemacs/jump-to-definition)))

(use-package python-mode
  :bind (:map python-mode-map
             ("M-<right>" . python-indent-shift-right)
             ("M-<left>" . python-indent-shift-left)))

(use-package markdown-mode
  :bind (:map markdown-mode-map
              ("M-<return>" . nil)))

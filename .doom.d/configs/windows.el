;;; ../src/dotfiles/.doom.d/configs/popper.el -*- lexical-binding: t; -*-

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Choosing-Window.html#Choosing-Window

(use-package! emacs
  :bind (("C-<prior>" . other-window)
         ("C-<next>" . (lambda () (interactive) (other-window -1)))))


(defun aleksei/popper-display-popup-at-bottom-or-right (buffer &optional alist)
  "Display popup-buffer BUFFER at the bottom of the screen."
  (let ((wide-frame-opts '((window-width . .5)
                           (side . right)
                           (slot . 1)))
        (narrow-frame-opts '((window-height . 0.33)
                             (side . bottom)
                             (slot . 1))))

    (display-buffer-in-side-window
     buffer
     (append alist
             (if (> (frame-width) 200) wide-frame-opts narrow-frame-opts)))))

(defun aleksei/other-popper-buffer-p (buffer)
  "Predicate to detect if BUFFER is a popup"
  (let ((buffer (if (bufferp buffer) buf (get-buffer buffer))))
    (with-current-buffer buffer
      (or (memq popper-popup-status '(popup user-popup))
          (unless (eq popper-popup-status 'raised)
            (popper-popup-p buffer))))))

(defun aleksei/3-columns-layout-p ()
  (and (>= (frame-width) 305)))

(defun aleksei/2-columns-layout-p ()
  (and (>= (frame-width) 200)
       (< (frame-width) 305)))

(defun aleksei/1-column-layout-p ()
  (< (frame-width) 200))

(setq display-buffer-alist
      '(
        ("\\*Flycheck error"
         (display-buffer-in-side-window)
         (window-height . popper--fit-window-height)
         (side . bottom)
         (slot . 1)
         (select . t))

        ;; ("\\*lsp-help"
        ;;  (display-buffer-in-side-window)
        ;;  (window-height . popper--fit-window-height)
        ;;  (side . bottom)
        ;;  (slot . 1)
        ;;  (select . t))

        ("\\*git-gutter:diff"
         (display-buffer-in-side-window)
         (window-height . popper--fit-window-height)
         (side . bottom)
         (slot . 1)
         (select . t))

        ((lambda (buff &optional alist) (and (aleksei/other-popper-buffer-p buff) (aleksei/3-columns-layout-p)))
         (display-buffer-in-side-window)
         (window-width . 0.33)
         (side . left)
         (slot . 1))

        ((lambda (buff &optional alist) (and (aleksei/other-popper-buffer-p buff) (aleksei/2-columns-layout-p)))
         (display-buffer-in-side-window)
         (window-width . 0.5)
         (side . right)
         (slot . 1))

        ((lambda (buff &optional alist) (and (aleksei/other-popper-buffer-p buff) (aleksei/1-column-layout-p)))
         (display-buffer-in-side-window)
         (window-height . 0.33)
         (side . bottom)
         (slot . 1))

        (".*" (display-buffer-reuse-mode-window))
        ))

(use-package popper
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-~" . popper-toggle-type))
  :custom
  (popper-display-control 'user)
  (popper-display-function #'aleksei/popper-display-popup-at-bottom-or-right)
  (popper-group-function #'popper-group-by-projectile)
  (popper-reference-buffers
        '("\\*Messages\\*"
          "\\*Warnings\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          "\\*doom eval\\*"
          "\\*doom:scratch"
          "\\*ert\\*"
          "\\*git-gutter:diff"
          "\\*SQL: "
          "\\*Flycheck error"

          helpful-mode help-mode

          compilation-mode comint-mode "\\*mocha"

          "\\*tree-sitter-tree:"

          "\\*cargo"

          "\\*rg"

          "\\*Embark"

          "^\\*eshell.*\\*$" eshell-mode ;eshell as a popup
          "^\\*shell.*\\*$"  shell-mode  ;shell as a popup
          "^\\*term.*\\*$"   term-mode   ;term as a popup
          "^\\*vterm.*\\*$"  vterm-mode  ;vterm as a popup

          grep-mode
          ))
  (popper-mode-line "")
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

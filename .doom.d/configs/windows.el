;;; ../src/dotfiles/.doom.d/configs/popper.el -*- lexical-binding: t; -*-

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
             (if (> (frame-parameter nil 'width) 200)
                 wide-frame-opts
               narrow-frame-opts)))))

(use-package popper
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-~" . popper-toggle-type))
  :custom
  (popper-display-function #'aleksei/popper-display-popup-at-bottom-or-right)
  (popper-group-function #'popper-group-by-projectile)
  (popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"

          helpful-mode help-mode

          compilation-mode comint-mode "\\*mocha"

          "^\\*eshell.*\\*$" eshell-mode ;eshell as a popup
          "^\\*shell.*\\*$"  shell-mode  ;shell as a popup
          "^\\*term.*\\*$"   term-mode   ;term as a popup
          "^\\*vterm.*\\*$"  vterm-mode  ;vterm as a popup

          grep-mode
          ))
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

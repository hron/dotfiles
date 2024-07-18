;;; ../src/dotfiles/.doom.d/configs/popper.el -*- lexical-binding: t; -*-

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Choosing-Window.html#Choosing-Window

(use-package! emacs
  :bind (("C-<prior>" . other-window)
         ("C-<next>" . (lambda () (interactive) (other-window -1)))
         ("M-i" . delete-other-windows)))

(defun aleksei/display-buffer-below-selected-then-fit-and-select (buffer)
  "Display BUFFER at the bottom of the window, fit the height to the
content, and select the window."
  (let ((window (display-buffer-below-selected buffer `((side . bottom)))))
    (fit-window-to-buffer window (floor (frame-height) 2))
    (select-window window)  ;; Select the window displaying the buffer
    window))

(defun aleksei/display-buffer-in-side-window (buffer &optional alist)
  "Display BUFFER at the appropriate place depending on the current frame width"
  (let* ((side-width (or (cdr (assq 'side-width alist)) .5))
         (side-height (or (cdr (assq 'side-height alist)) .33))
         (wide-frame-opts `(list
                            (window-width . ,side-width)
                            (side . left)))
         (narrow-frame-opts `(list
                              (window-height . ,side-height)
                              (side . bottom))))

    (display-buffer-in-side-window
     buffer
     (append alist
             (if (> (frame-width) 200) wide-frame-opts narrow-frame-opts))
     )))

(defun aleksei/3-columns-layout-p ()
  (and (>= (frame-width) 305)))

(defun aleksei/2-columns-layout-p ()
  (and (>= (frame-width) 200)
       (< (frame-width) 305)))

(defun aleksei/1-column-layout-p ()
  (< (frame-width) 200))

(setq display-buffer-alist
      '(
        ;; ((or . ("\\*Warnings\\*"
        ;;         "\\*projectile-files-errors\\*"))
        ;;  (display-buffer-no-window)
        ;;  (allow-no-window . t))

        ((or . ((derived-mode . process-menu-mode)
                (derived-mode . flycheck-error-list-mode)
                ;; "\\*diff-hl"
                ))
         (display-buffer-reuse-mode-window aleksei/display-buffer-below-selected-then-fit-and-select))

        ("magit-revision"
         (aleksei/display-buffer-in-side-window)
         (side-width . .55)
         (side-height . .67))

        ((or . ("^\\*"
                "Output\\*$"
                (derived-mode . compilation-mode)
                (derived-mode . comint-mode)))
         (aleksei/display-buffer-in-side-window)
         (side-width . .45)
         (side-height . .33))

        (".*"
         (display-buffer-reuse-mode-window))

        ))

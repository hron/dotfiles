;;; ../src/dotfiles/.doom.d/configs/popper.el -*- lexical-binding: t; -*-

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Choosing-Window.html#Choosing-Window

(use-package! emacs
  :bind (("C-<next>" . other-window)
         ("C-<prior>" . (lambda () (interactive) (other-window -1)))
         ("M-i" . delete-other-windows)))

(setq aleksei/default-side-window-width .45
      aleksei/default-side-window-height .33)

(defun aleksei/display-buffer-below-selected-then-fit-and-select (buffer &optional alist)
  "Display BUFFER at the bottom of the window, fit the height to the
content, and select the window."
  (let ((window (display-buffer-below-selected buffer `((side . bottom)))))
    (fit-window-to-buffer window (floor (frame-height) 2))
    (select-window window)  ;; Select the window displaying the buffer
    window))

(defun aleksei/display-buffer-in-side-window (buffer &optional alist)
  "Display BUFFER at the appropriate place depending on the current frame width"
  (let* ((side-width (or (cdr (assq 'side-width alist)) aleksei/default-side-window-width))
         (side-height (or (cdr (assq 'side-height alist)) aleksei/default-side-window-height))
         (wide-frame-opts `(list
                            (window-width . ,side-width)
                            (side . left)))
         (narrow-frame-opts `(list
                              (window-height . ,side-height)
                              (side . bottom))))

    (display-buffer-in-side-window
     buffer
     (append alist
             (if (aleksei/2-columns-layout-p) wide-frame-opts narrow-frame-opts))
     )))

(defun aleksei/display-buffer-in-side-window-if-wide (buffer &optional alist)
  (if (aleksei/2-columns-layout-p)
      (display-buffer-in-side-window
       buffer
       (append alist  `(list (side . left)
                        (window-width . ,aleksei/default-side-window-width))))
    (display-buffer-same-window buffer alist)))

(defun aleksei/2-columns-layout-p ()
  (>= (frame-width) 200))

(defun aleksei/1-column-layout-p ()
  (not (aleksei/2-columns-layout-p)))

(setq display-buffer-alist
      '(
        ((or . ((derived-mode . process-menu-mode)
                (derived-mode . flycheck-error-list-mode)
                ;; "\\*diff-hl"
                ))
         (display-buffer-reuse-mode-window
          aleksei/display-buffer-below-selected-then-fit-and-select))

        ((or . ("\\*Org"
                ))
         (display-buffer-reuse-window
          display-buffer-same-window))

        ((or . ("\\*ChatGPT"))
         (aleksei/display-buffer-in-side-window-if-wide))

        ((or . ("^\\*"
                "Output\\*$"
                "^magit-log"
                "^magit-revision"
                (derived-mode . compilation-mode)
                (derived-mode . comint-mode)))
         (aleksei/display-buffer-in-side-window))

        (".*"
         (display-buffer-reuse-mode-window))

        ))

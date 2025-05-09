;;; ../src/dotfiles/.doom.d/configs/popper.el -*- lexical-binding: t; -*-

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Choosing-Window.html#Choosing-Window

(use-package! emacs
  :defer t
  :ensure nil
  :bind (("C-<next>" . other-window)
         ("C-<prior>" . (lambda () (interactive) (other-window -1)))
         ("M-i" . delete-other-windows)))

(defvar algus/default-side-window-width .5)
(defvar algus/default-side-window-height .33)

(defun algus/display-buffer-below-selected-then-fit-and-select (buffer &optional alist)
  "Display BUFFER at the bottom of the window, apply ALIST.

Fit the height to the content, and select the window."
  (let ((window (display-buffer-below-selected buffer `((side . bottom)))))
    (fit-window-to-buffer window (floor (frame-height) 2))
    (select-window window)  ;; Select the window displaying the buffer
    window))

(defun algus/display-buffer-in-side-window (buffer &optional alist)
  "Display BUFFER at the appropriate place depending on the current frame width"
  (let* ((side-width (or (cdr (assq 'side-width alist)) algus/default-side-window-width))
         (side-height (or (cdr (assq 'side-height alist)) algus/default-side-window-height))
         (wide-frame-opts `(list
                            (window-width . ,side-width)
                            (side . left)))
         (narrow-frame-opts `(list
                              (window-height . ,side-height)
                              (side . bottom))))

    (display-buffer-in-side-window
     buffer
     (append alist
             (if (algus/2-columns-layout-p) wide-frame-opts narrow-frame-opts))
     )))

(defun algus/display-buffer-in-side-window-if-wide (buffer &optional alist)
  (if (algus/2-columns-layout-p)
      (display-buffer-in-side-window
       buffer
       (append alist  `(list (side . left)
                        (window-width . ,algus/default-side-window-width))))
    (display-buffer-same-window buffer alist)))

(defun algus/2-columns-layout-p ()
  (>= (frame-width) 200))

(defun algus/1-column-layout-p ()
  (not (algus/2-columns-layout-p)))

(setq display-buffer-alist
      '(
        ((or . ((derived-mode . process-menu-mode)
                (derived-mode . flycheck-error-list-mode)
                "\\*RE-Builder\\*"
                ;; "\\*diff-hl"
                ))
         (display-buffer-reuse-mode-window
          algus/display-buffer-below-selected-then-fit-and-select))

        ((or . ("\\*Org Agenda"
                "\\*doom:scratch"
                ))
         (display-buffer-reuse-window
          display-buffer-same-window))

        ((or . ("\\*ChatGPT"
                "^magit-log"
                "^magit-revision"
                (derived-mode . magit-status-mode)
                "\\*Man"))
         (algus/display-buffer-in-side-window-if-wide))

        ((or . ("^\\*"
                "Output\\*$"
                (derived-mode . compilation-mode)
                (derived-mode . comint-mode)))
         (display-buffer-reuse-window
          algus/display-buffer-in-side-window))))

(defvar algus/redisplay-last-frame-width (frame-total-cols))

(defun algus/redisplay-side-windows ()
  (when (not (eq algus/redisplay-last-frame-width (frame-total-cols)))
    (setq algus/redisplay-last-frame-width (frame-total-cols))
    (let ((closed-bufs))
      (dolist (win (window-list))
        (when (and (window-parameter win 'window-side)
                   (window-live-p win))
          (push (window-buffer win) closed-bufs)
          (delete-window win)))
      (message "%s" closed-bufs)
      (dolist (buf closed-bufs)
        (pop-to-buffer buf)))))

(add-hook 'window-state-change-hook #'algus/redisplay-side-windows)

;;; ../src/dotfiles/.doom.d/configs/indent-rigidly.el -*- lexical-binding: t; -*-

;;; https://www.emacswiki.org/emacs/IndentRigidlyN
(defun aleksei/indent-rigidly (n)
  "Indent the region, or otherwise the current line, by N spaces."
  (let* ((use-region (and transient-mark-mode mark-active))
         (rstart (if use-region (region-beginning) (point-at-bol)))
         (rend   (if use-region (region-end)       (point-at-eol)))
         (deactivate-mark "irrelevant")) ; avoid deactivating mark
    (indent-rigidly rstart rend n)))

;; (defun aleksei/indent-rigidly-right ()
;;   "Indent the region, or otherwise the current line, by 4 spaces."
;;   (interactive)
;;   (if (aleksei/current-line-empty-p)
;;       (indent-for-tab-command))
;;   (aleksei/indent-rigidly tab-width))
(defun aleksei/indent-rigidly-right ()
  "Indent the region, or otherwise the current line, by 4 spaces."
  (interactive)
  (aleksei/indent-rigidly tab-width))

(defun aleksei/indent-rigidly-left ()
  "Indent the region, or otherwise the current line, by -tab-width spaces."
  (interactive)
  (aleksei/indent-rigidly (- tab-width)))

(use-package! emacs
  :bind (:map prog-mode-map
              ("<tab>" . aleksei/indent-rigidly-right)
              ("<backtab>" . aleksei/indent-rigidly-left)))

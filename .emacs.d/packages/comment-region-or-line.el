;; I like this little function to be bound as a keyboard shortcut.
;; It was contributed to XEmacs, but I never have seen it there (yet).

;; Public domain. Originally by Vasily Korytov.

(defun comment-region-or-line (arg)
  "Comment the selected region or the following line."
  (interactive "p")
  (if (featurep 'xemacs)
      ;; xemacs version
      (if (region-active-p)
	  (comment-region (region-beginning) (region-end) arg)
	(comment-region (point-at-bol) (point-at-eol) arg))

    ;; emacs version
    ;;
    ;; Bug: it works quite poorly without transient-mark-mode.
    ;; (Or, maybe, it's the suggested behaviour?)
    (if mark-active
	(comment-region (region-beginning) (region-end) arg)
      (comment-region (line-beginning-position) (line-end-position) arg))))

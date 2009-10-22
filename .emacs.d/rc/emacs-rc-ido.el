;; Use C-f during file selection to switch to regular find-file
(ido-mode t)  ; use 'buffer rather than t to use only buffer switching
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point t)
(setq ido-auto-merge-work-directories-length 0)

;;----------------------------------------------------------------------------
;; ido completion in M-x
;;----------------------------------------------------------------------------
;; See http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings#toc5
(defun ido-execute ()
  (interactive)
  (call-interactively
   (intern
    (ido-completing-read
     "M-x "
     (let (cmd-list)
       (mapatoms (lambda (S) (when (commandp S) (setq cmd-list (cons (format "%S" S) cmd-list)))))
       cmd-list)))))

(global-set-key "\M-x" 'ido-execute)

(provide 'emacs-rc-ido)

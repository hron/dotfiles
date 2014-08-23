(setq ido-enable-flex-matching t
      ido-use-filename-at-point 'guess
      ido-use-url-at-point t
      ido-everywhere t)

(setq ido-default-file-method 'selected-window
      ido-default-buffer-method 'selected-window)

(setq ido-auto-merge-work-directories-length 0)

(setq ffap-require-prefix t
      dired-at-point-require-prefix t
      ffap-machine-p-known 'accept)
;; FFAP mode replaces certain key bindings for finding files,
;; including `C-x C-f', with commands that provide more sensitive
;; defaults. These commands behave like the ordinary ones when given a
;; prefix argument. Otherwise, they get the default file name or URL
;; from the text around point. If what is found in the buffer has the
;; form of a URL rather than a file name, the commands use
;; `browse-url' to view it.
;; (ffap-bindings)

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

(ido-mode t)  ; use 'buffer rather than t to use only buffer switching

(provide 'emacs-rc-ido)

;;; emacs-rc-kbd.el -- some bindings

;; Bind `F2' to call shell
(global-set-key [f5] 'shell)

;; Bind `F6' to toggle truncation lines
(global-set-key [f6] 'toggle-truncate-lines)

;; Bind `F9' to compile function
;; (global-set-key [f9] 'compile)
(global-set-key [f9] '(lambda (command &optional comint)
			(interactive
			 (list
			  (let ((command (eval compile-command)))
			    (if (or compilation-read-command current-prefix-arg)
				(compilation-read-command command)
			      command))
			  (consp current-prefix-arg)))
			(setq comint (not comint))
			(compile command comint)))

(global-set-key [f10] 'anything)

(global-set-key [f12] 'align-regexp)

;; Bind `C-x C-b' to more convenience
(global-set-key "\C-x\C-b" 'ibuffer)

;; and to kill too..
(global-set-key "\C-xk" 'kill-this-buffer)

(global-set-key [(control c) (i)] 'overwrite-mode)
(global-set-key [(control c) (r)] '(lambda (&optional arg)
				     (interactive "*P")
				     (if arg
					 (auto-revert-mode)
				       (revert-buffer))))

;; `M-x hippie-expand' is a single command providing a variety of
;; completions and expansions.  Called repeatedly, it tries all possible
;; completions in succession.
(global-set-key "\M-/" 'hippie-expand)

;; The variable `woman-topic-at-point' can also be rebound locally (using
;; `let'), which may be useful to provide special private key bindings,
;; e.g. this key binding for `C-c w' runs WoMan on the topic at point
;; without seeking confirmation:
(global-set-key "\C-cw"
		(lambda ()
		  (interactive)
		  (let ((woman-topic-at-point t))
		    (woman))))

;; Bind `C-c l' to `locate' command
;; (global-set-key "\C-co" 'locate)
(global-set-key "\C-co" '(lambda ()
			   (interactive)
			   (anything-other-buffer
			    '(anything-c-source-locate)
			    " *anything-locate*")))


;; Bind `C-c g' to `grep-find' command
(global-set-key "\C-cg" 'rgrep)
;; (global-set-key "\C-cg" (lambda ()
;; 			  (interactive)
;; 			  (if (vc-git-root default-directory)
;; 			      (vc-git-grep)
;; 			    (rgrep))))

;; Bind `C-c f' to `find-grep-dired' command
(global-set-key "\C-cf" 'find-grep-dired)

;; Bind `C-c v' to `view-mode' command
(global-set-key "\C-cv" 'view-mode)

;; Bind `C-c C' to `calendar' command
(global-set-key "\C-cC" 'calendar)

(global-set-key "\C-ct" 'GAU:box-region-with-title)
(global-set-key "\C-ce" 'boxquote-shell-command)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; Magit
(global-set-key [f11] 'magit-status)

;; Kill-ring-search
(global-set-key "\M-\C-y" 'kill-ring-search)

;; etags-select
(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

(global-unset-key (kbd "C-z"))

(provide 'emacs-rc-kbd)
;; emacs-rc-kbd.el

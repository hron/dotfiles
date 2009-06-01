;;; emacs-rc-kbd.el -- some bindings

;; Bind `F2' to call shell
(global-set-key [f5] 'eshell)

;; Bind `F6' to toggle truncation lines
(global-set-key [f6] 'toggle-truncate-lines)

;; Bind `F9' to compile function
;; (global-set-key [f9] 'GAU:Compile)

(global-set-key [f11] 'speedbar)
(global-set-key [f12] 'align)

;; Bind `C-x C-b' to more convenience
(global-set-key "\C-x\C-b" 'bs-show)

;; and to kill too..
(global-set-key "\C-xk" 'kill-this-buffer)

(global-set-key [(control c) (i)] 'overwrite-mode)
(global-set-key [(control c) (r)] 'revert-buffer)
(global-set-key [(control c) (f)] 'font-lock-mode)

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
(global-set-key "\C-cl" 'locate)

;; Bind `C-c g' to `grep-find' command
(global-set-key "\C-cg" 'rgrep)

;; Bind `C-c f' to `find-grep-dired' command
(global-set-key "\C-cf" 'find-grep-dired)

;; Bind `C-c v' to `view-mode' command
(global-set-key "\C-cv" 'view-mode)

;; Bind `C-c C' to `calendar' command
(global-set-key "\C-cC" 'calendar)

(global-set-key "\C-cb" 'GAU:box-region-with-title)
(global-set-key "\C-ce" 'boxquote-shell-command)

;; emacs-rc-kbd.el
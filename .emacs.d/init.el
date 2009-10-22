;;; ~/.emacs.d/init.el

;; Copyright (C) 2004, 2005, 2006, 
;;               2007, 2008, 2009 Aleksei Gusev <aleksei.gusev@gmail.com>

;; Started: 1 June 2004
;; Version: $Id$

;; TODO:
;; 
;;  * Shadow copies of files do not work with tramp.
;;  * Status of remote executed grep still 'running' forever.
;;  * Add smarty-mode.
;;  
;; Done:
;; 
;;  * Reconfigure emacsclient:
;; 
;;     - there is a new option '-c' for creating new frame without
;;       using existing (as I remember I use some elisp code to
;;       achieve this behaviour).
;;
;;     - make openning a new frame by 'Win-E' without '~/src' in
;;       buffer and with --no-wait option.
;; 
;;  * Deleting files in trash.
;;  * Moved session files somewhere.
;;


;; Add some dirs to load-path
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/site-lisp/")
           (default-directory my-lisp-dir))
      (progn
        (setq load-path (cons my-lisp-dir load-path))
        (normal-top-level-add-subdirs-to-load-path))))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rc"))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
		(load
		 (expand-file-name "~/.emacs.d/elpa/package.el"))
	(package-initialize))

;; Shell
(add-hook 'sh-mode-hook '(lambda ()
													 (turn-on-auto-fill)
													 (highlight-parentheses-mode 1))

;; Emacs-Lisp
(add-hook 'emacs-lisp-mode-hook '(lambda ()
																	 (turn-on-auto-fill)
																	 (highlight-parentheses-mode 1)))

;; Text
(add-hook 'text-mode-hook '(lambda ()
														 (turn-on-auto-fill)
														 (turn-on-flyspell)
														 (highlight-parentheses-mode 1)))

;; Octave
(require 'emacs-rc-octave)

;; PHP
(require 'emacs-rc-php)

;; TeX
(require 'emacs-rc-tex)

;; Gentoo Syntax (ebuild, init.d-scripts and etc)
(require 'gentoo-syntax)

(add-to-list 'auto-mode-alist
						 '("/etc/conf.d/" . sh-mode))

;; Javascript
(require 'emacs-rc-javascript)

;; Apache
(add-to-list 'auto-mode-alist '(".*/etc/apache.*" . apache-mode))

;; Textile
(require 'emacs-rc-textile)

;; Emacs Rails Reloaded
;; FIXME: I do not know why, but we have to add emacs-rails-reloaded
;; to load path explicity...
(setq load-path (cons (expand-file-name
											 "~/.emacs.d/site-lisp/emacs-rails-reloaded") load-path))
(require 'rails-autoload)

;; RHTML
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-mode))

;; Ruby
(require 'emacs-rc-ruby)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-hook 'yaml-mode-hook
					'(lambda ()
						 (setq indent-tabs-mode nil)
						 (highlight-parentheses-mode 1)))

;; Magit
(global-set-key [f11] 'magit-status)

(global-set-key "\M-\C-y" 'kill-ring-search)

;; Emacs core customization
(require 'emacs-rc-calendar)
(require 'emacs-rc-decor)
(require 'emacs-rc-dired)
(require 'emacs-rc-hippie-exp)
(require 'emacs-rc-gdb)
(require 'emacs-rc-mule)
(require 'emacs-rc-tramp)
(require 'emacs-rc-woman)
(require 'emacs-rc-user-info)
(require 'emacs-rc-ldap)
(require 'emacs-rc-eudc)
(require 'emacs-rc-kbd)

;; Everything else...
(require 'emacs-rc-misc-things)


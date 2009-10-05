;;; ~/.emacs

;; Copyright (C) 2004, 2005, 2006, 
;;               2007, 2008, 2009 Aleksei Gusev <aleksei.gusev@gmail.com>

;; Started: 1 June 2004
;; Version: $Id$

;; TODO:
;; 
;;  * Deleting files in trash.
;;  * Shadow copies of files do not work with tramp.
;;  * Status of remote executed grep still 'running' forever.
;;  * Moved session files somewhere.
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


;; Add some dirs to load-path
(setq load-path (cons "~/.emacs.d/packages" load-path))

;; loading alternative git client.
;; (load "/usr/share/doc/git-core/contrib/emacs/git")

;; EMMS
(load "~/.emacs.d/rc/emacs-rc-emms")

;; Mode specific configurations
(load "~/.emacs.d/rc/emacs-rc-sh-scripts")
(load "~/.emacs.d/rc/emacs-rc-lisp")
(load "~/.emacs.d/rc/emacs-rc-text")
(load "~/.emacs.d/rc/emacs-rc-sql")
(load "~/.emacs.d/rc/emacs-rc-php")
(load "~/.emacs.d/rc/emacs-rc-tex")
(load "~/.emacs.d/rc/emacs-rc-js2")
(load "~/.emacs.d/rc/emacs-rc-gentoo-syntax")
(load "~/.emacs.d/rc/emacs-rc-javascript")
(load "~/.emacs.d/rc/emacs-rc-apache-mode")

;; Ruby, Rails and all, all, all.. ;]
(load "~/.emacs.d/rc/emacs-rc-rails-reloaded")
;; (load "~/.emacs.d/rc/emacs-rc-rails")
(load "~/.emacs.d/rc/emacs-rc-rhtml")
(load "~/.emacs.d/rc/emacs-rc-ri")
(load "~/.emacs.d/rc/emacs-rc-ruby")
(load "~/.emacs.d/rc/emacs-rc-yaml")

;; (load "~/.emacs.d/rc/emacs-rc-nxhtml")

;; Emacs core customization
(load "~/.emacs.d/rc/emacs-rc-calendar")
(load "~/.emacs.d/rc/emacs-rc-decor")
(load "~/.emacs.d/rc/emacs-rc-dired")
(load "~/.emacs.d/rc/emacs-rc-hippie-exp")
(load "~/.emacs.d/rc/emacs-rc-gdb")
(load "~/.emacs.d/rc/emacs-rc-mule")
(load "~/.emacs.d/rc/emacs-rc-misc-things")
(load "~/.emacs.d/rc/emacs-rc-tramp")
(load "~/.emacs.d/rc/emacs-rc-woman")
(load "~/.emacs.d/rc/emacs-rc-user-info")
(load "~/.emacs.d/rc/emacs-rc-vc")
(load "~/.emacs.d/rc/emacs-rc-ldap")
(load "~/.emacs.d/rc/emacs-rc-eudc")
(load "~/.emacs.d/rc/emacs-rc-kbd")
(load "~/.emacs.d/rc/emacs-rc-smtpmail")
(load "~/.emacs.d/rc/emacs-rc-ediff")

;; Control use of local variables in files you visit.
;; The value can be t, nil, :safe, :all, or something else.
;; 
;; A value of t means file local variables specifications are obeyed
;; if all the specified variable values are safe; if any values are
;; not safe, Emacs queries you, once, whether to set them all.
;; (When you say yes to certain values, they are remembered as safe.)
;; 
;; :safe means set the safe variables, and ignore the rest.
;; :all means set all variables, whether safe or not.
;;  (Don't set it permanently to :all.)
;; A value of nil means always ignore the file local variables.
;; 
;; Any other value means always query you once whether to set them all.
;; (When you say yes to certain values, they are remembered as safe, but
;; this has no effect when `enable-local-variables' is "something else".)
;; 
;; This variable also controls use of major modes specified in
;; a -*- line.
;; 
;; The command M-x normal-mode, when used interactively,
;; always obeys file local variable specifications and the -*- line,
;; and ignores this variable.
(setq enable-local-variables :all)

;; Color theme loading, must be the last.
(load-library "color-themes/color-theme-dark-hron")
(color-theme-dark-hron)

(put 'scroll-left 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(canlock-password "e6a803bd4bbe7baa935108fb943f3df19651b148")
 '(safe-local-variable-values (quote ((phpunit-run-directory . "/home/gusev/src/z/zanby/core") (js2-strict-missing-semi-warning) (js2-strict-missing-semi-warning . 100) (c-hanging-comment-ender-p) (folded-file . t) (folding-internal-margins) (sgml-omittag . t) (sgml-shorttag . t) (sgml-minimize-attributes) (sgml-always-quote-attributes . t) (sgml-indent-step . 2) (sgml-indent-data . t) (sgml-parent-document) (sgml-default-dtd-file) (sgml-exposed-tags) (sgml-local-catalogs) (sgml-local-ecat-files) (encoding . koi8-r)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'set-goal-column 'disabled nil)

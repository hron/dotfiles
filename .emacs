;;; ~/.emacs

;; Copyright (C) 2004, 2005, 2006, 
;;               2007, 2008, 2009 Aleksei Gusev <aleksei.gusev@gmail.com>

;; Started: 1 June 2004
;; Version: $Id$

;; TODO:
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
;;  * Shadow copies of files do not work with tramp.
;;  * Status of remote executed grep still 'running' forever.


;; Add some dirs to load-path
(setq load-path (cons "~/.emacs.d/packages" load-path))

(load-library "smarty-mode")
(load-library "crontab-mode")

(setq load-path (cons "~/.emacs.d/packages/gentoo-syntax" load-path))
(load-library "gentoo-syntax")

(load "~/.emacs.d/rc/emacs-rc-autotyping")
;; (load "~/.emacs.d/rc/emacs-rc-anything")
(load "~/.emacs.d/rc/emacs-rc-apache")
(load "~/.emacs.d/rc/emacs-rc-calendar")
(load "~/.emacs.d/rc/emacs-rc-cmode")
(load "~/.emacs.d/rc/emacs-rc-css-mode")
(load "~/.emacs.d/rc/emacs-rc-cperl-mode")
(load "~/.emacs.d/rc/emacs-rc-crontab")
(load "~/.emacs.d/rc/emacs-rc-decor")
(load "~/.emacs.d/rc/emacs-rc-dict")
(load "~/.emacs.d/rc/emacs-rc-dired")
;; ;; (load "~/.emacs.d/rc/emacs-rc-doxymacs")
(load "~/.emacs.d/rc/emacs-rc-ecb")
(load "~/.emacs.d/rc/emacs-rc-eshell")
(load "~/.emacs.d/rc/emacs-rc-hyperlinking")
;; (load "~/.emacs.d/rc/emacs-rc-info")
(load "~/.emacs.d/rc/emacs-rc-kbd")
(load "~/.emacs.d/rc/emacs-rc-misc-things")
(load "~/.emacs.d/rc/emacs-rc-mouse")
(load "~/.emacs.d/rc/emacs-rc-mule")
(load "~/.emacs.d/rc/emacs-rc-octave")
(load "~/.emacs.d/rc/emacs-rc-prog-misc")
(load "~/.emacs.d/rc/emacs-rc-sh-scripts")
(load "~/.emacs.d/rc/emacs-rc-smtpmail")
(load "~/.emacs.d/rc/emacs-rc-tex")
(load "~/.emacs.d/rc/emacs-rc-text")
(load "~/.emacs.d/rc/emacs-rc-user-info")
(load "~/.emacs.d/rc/emacs-rc-w3")
(load "~/.emacs.d/rc/emacs-rc-woman")
(load "~/.emacs.d/rc/emacs-rc-emms")
(load "~/.emacs.d/rc/emacs-rc-tramp")
(load "~/.emacs.d/rc/emacs-rc-bbdb")
;; (load "~/.emacs.d/rc/emacs-rc-lsdb")
;; (load "~/.emacs.d/rc/emacs-rc-ldap")
(load "~/.emacs.d/rc/emacs-rc-eudc")
(load "~/.emacs.d/rc/emacs-rc-liece")
;; (load "~/.emacs.d/rc/emacs-rc-semantic")
(load "~/.emacs.d/rc/emacs-rc-view-mode")
(load "~/.emacs.d/rc/emacs-rc-vc")
(load "~/.emacs.d/rc/emacs-rc-server")
;; (load "~/.emacs.d/rc/emacs-rc-php")
(load "~/.emacs.d/rc/emacs-rc-gdb")
(load "~/.emacs.d/rc/emacs-rc-git")
(load "~/.emacs.d/rc/emacs-rc-ruby")
(load "~/.emacs.d/rc/emacs-rc-rails-reloaded")
;; (load "~/.emacs.d/rc/emacs-rc-rails")
(load "~/.emacs.d/rc/emacs-rc-rhtml")
(load "~/.emacs.d/rc/emacs-rc-ri")
(load "~/.emacs.d/rc/emacs-rc-yaml")
(load "~/.emacs.d/rc/emacs-rc-sql")
(load "~/.emacs.d/rc/emacs-rc-hippie-exp")
;; (load "~/.emacs.d/rc/emacs-rc-icicles.el")
(load "~/.emacs.d/rc/emacs-rc-uniquify")


(load-library "color-theme-dark-hron")
(color-theme-dark-hron)

(put 'scroll-left 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(canlock-password "e6a803bd4bbe7baa935108fb943f3df19651b148")
 '(safe-local-variable-values (quote ((sgml-omittag . t) (sgml-shorttag . t) (sgml-minimize-attributes) (sgml-always-quote-attributes . t) (sgml-indent-step . 2) (sgml-indent-data . t) (sgml-parent-document) (sgml-default-dtd-file) (sgml-exposed-tags) (sgml-local-catalogs) (sgml-local-ecat-files) (encoding . koi8-r)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'set-goal-column 'disabled nil)

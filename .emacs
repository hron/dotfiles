;;; ~/.emacs

;; Copyright (C) 2004, 2005, 2006, 2007, 2008  Aleksei Gusev <ag@aichyna.com>

;; Started: 1 June 2004
;; Version: $Id$

;; Add some dirs to load-path
(setq load-path (cons "~/.emacs.d/packages" load-path))

;; (load-library "fvwm")
;; (load-library "fetchmail-mode")
;; (load-library "clone-line")
;; ;;(load-library "freq-mode")
;; (load-library "procmail-mode")
;; ;; (load-library "rpm-spec-mode")
;; ;; (load-library "syslog-mode")
(load-library "smarty-mode")
(load-library "crontab-mode")
;; (load-library "anything-config")
;; (load-library "rcodetools")
;; (load-library "anything-rcodetools")
;; (load-library "flymake-php")

(load "~/.emacs.d/rc/emacs-rc-autotyping")
(load "~/.emacs.d/rc/emacs-rc-anything")
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
(load "~/.emacs.d/rc/emacs-rc-tex")
(load "~/.emacs.d/rc/emacs-rc-text")
(load "~/.emacs.d/rc/emacs-rc-user-info")
(load "~/.emacs.d/rc/emacs-rc-w3")
(load "~/.emacs.d/rc/emacs-rc-woman")
;; (load "~/.emacs.d/rc/emacs-rc-emms")
(load "~/.emacs.d/rc/emacs-rc-tramp")
(load "~/.emacs.d/rc/emacs-rc-bbdb")
;; (load "~/.emacs.d/rc/emacs-rc-lsdb")
;; (load "~/.emacs.d/rc/emacs-rc-ldap")
(load "~/.emacs.d/rc/emacs-rc-eudc")
(load "~/.emacs.d/rc/emacs-rc-liece")
;; (load "~/.emacs.d/rc/emacs-rc-semantic")
(load "~/.emacs.d/rc/emacs-rc-view-mode")
(load "~/.emacs.d/rc/emacs-rc-server")
;; (load "~/.emacs.d/rc/emacs-rc-php")
(load "~/.emacs.d/rc/emacs-rc-gdb")
;; (load "~/.emacs.d/rc/emacs-rc-git")
(load "~/.emacs.d/rc/emacs-rc-ruby")
(load "~/.emacs.d/rc/emacs-rc-rails")
(load "~/.emacs.d/rc/emacs-rc-rhtml")
(load "~/.emacs.d/rc/emacs-rc-ri")
(load "~/.emacs.d/rc/emacs-rc-yaml")
(load "~/.emacs.d/rc/emacs-rc-sql")
(load "~/.emacs.d/rc/emacs-rc-hippie-exp.el")
;; (load "~/.emacs.d/rc/emacs-rc-icicles.el")

;; (gnus)                                  ; ;(


(put 'scroll-left 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . koi8-r)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

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
(setq load-path (cons "~/.emacs.d/site-lisp" load-path))

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
(load "~/.emacs.d/rc/emacs-rc-textile")

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

;;----------------------------------------------------------------------------
;; Desktop saving
;;----------------------------------------------------------------------------
;; save a list of open files in ~/.emacs.d/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-path '("~/.emacs.d"))
(setq desktop-save 'if-exists)
(desktop-save-mode 1)


;;----------------------------------------------------------------------------
;; Restore histories and registers after saving
;;----------------------------------------------------------------------------
(require 'session)
(setq session-save-file (expand-file-name "~/.emacs.d/.session"))
(add-hook 'after-init-hook 'session-initialize)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (ido-last-directory-list  . 100)
                (ido-work-directory-list  . 100)
                (ido-work-file-list       . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))


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

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Color theme loading, must be the last.
(load-library "color-themes/color-theme-dark-hron")
(color-theme-dark-hron)


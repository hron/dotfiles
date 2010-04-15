;;; ~/.emacs.d/init.el

;; Copyright (C) 2004, 2005, 2006,
;;               2007, 2008, 2009 Aleksei Gusev <aleksei.gusev@gmail.com>

;; Started: 1 June 2004
;; Version: $Id$

;; TODO:
;;
;;  * Shadow copies of files do not work with tramp.
;;  * Status of remote executed grep still 'running' forever.
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
;;  * Add smarty-mode.
;;


;; Add some dirs to load-path
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir (expand-file-name "~/.emacs.d/site-lisp/"))
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

(require 'server)

;;----------------------------------------------------------------------------
;; Handier way to add modes to auto-mode-alist
;;----------------------------------------------------------------------------
(defun add-auto-mode (mode &rest patterns)
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

;; Shell
(require 'emacs-rc-sh)

;; Emacs-Lisp
(add-hook 'emacs-lisp-mode-hook '(lambda ()
                                   (turn-on-auto-fill)
                                   (flyspell-prog-mode)
                                   ;; (turn-on-orgstruct)
                                   ;; (turn-on-orgtbl)
                                   (highlight-parentheses-mode 1)))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)


;; Text
(add-hook 'text-mode-hook '(lambda ()
                             (turn-on-auto-fill)
                             (turn-on-flyspell)
                             ;; (turn-on-orgstruct)
                             ;; (turn-on-orgtbl)
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

;; Markdown
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; Regex-tool
(autoload 'regex-tool "regex-tool" "Mode for exploring regular expressions" t)

;; Git
(require 'emacs-rc-git)

;; Emacs Rails Reloaded
;; FIXME: I do not know why, but we have to add emacs-rails-reloaded
;; to load path explicity...
(setq load-path (cons (expand-file-name
                       "~/.emacs.d/site-lisp/emacs-rails-reloaded") load-path))
(require 'rails-autoload)

;; RHTML
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-mode))
(add-hook 'rhtml-mode-hook '(lambda ()
                              (flyspell-prog-mode)
                              ;; (turn-on-orgstruct)
                              ;; (turn-on-orgtbl)))
                              ))
;; Ruby
(require 'emacs-rc-ruby)
(require 'rvm)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (flyspell-prog-mode)
             ;; (turn-on-orgstruct)
             ;; (turn-on-orgtbl)
             (highlight-parentheses-mode 1)))

;; htmlize
(dolist (sym
         (list 'htmlize-file 'htmlize-region 'htmlize-buffer
               'htmlize-many-files 'htmlize-many-files-dired))
  (autoload sym "htmlize"))

;; SQL
;; (eval-after-load "sql"
;;   '(load-library "sql-indent"))


;; ERC
(require 'emacs-rc-erc)

;; Python
(require 'emacs-rc-python)

;; ANSI colors
(require 'emacs-rc-tty-format)

;; el4r
(with-demoted-errors
  (require 'emacs-rc-el4r))

;; Anything
(require 'emacs-rc-anything)

;; Jabber
(add-to-list 'load-path (concat (getenv "HOME")
                               "/.emacs.d/site-lisp/emacs-jabber-0.8.0"))

;; ditz
(require 'ditz)

;; EMMS
(require 'emacs-rc-emms)

;;
;; Emacs core customization
;;

;; EShell
(require 'emacs-rc-eshell)

;; Spelling
(setq ispell-dictionary "en_US")

;; Filladapt
(setq-default filladapt-mode t)

;; comint-mode
(setq comint-scroll-to-bottom-on-output 'others)

;; Org-mode
(require 'emacs-rc-org)

(require 'emacs-rc-flymake)
(require 'emacs-rc-ido)
(require 'emacs-rc-calendar)
(require 'emacs-rc-decor)
(require 'emacs-rc-dired)
(require 'emacs-rc-hippie-exp)
(require 'emacs-rc-gdb)
(require 'emacs-rc-mule)
(require 'emacs-rc-tramp)
(require 'emacs-rc-woman)
(require 'emacs-rc-ldap)
(require 'emacs-rc-view)
(require 'emacs-rc-bbdb)

(require 'emacs-rc-user-info)
(require 'emacs-rc-kbd)

;; Everything else...
(require 'emacs-rc-misc-things)

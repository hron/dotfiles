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

(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

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

;; Java script
(setq js-indent-level 2)

;; Apache
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

;; Markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Regex-tool
(autoload 'regex-tool "regex-tool" "Mode for exploring regular expressions" t)

;; Git
(require 'emacs-rc-git)

;; Ruby
(require 'emacs-rc-ruby)
(require 'rvm)

(require 'rinari)
(add-to-list 'rinari-major-modes 'magit-mode-hook)

(defun rinari-web-server (&optional edit-cmd-args)
  "Starts a Rails webserver.  Dumps output to a compilation buffer
allowing jumping between errors and source code.  With optional prefix
argument allows editing of the server command arguments."
  (interactive "P")
  (let* ((default-directory (rinari-root))
         (script (rinari-script-path))
         (command
          (expand-file-name
           (if (file-exists-p (expand-file-name "server" script))
               "server"
             "rails server")
           script)))

    ;; Start web server in correct environment.
    ;; NOTE: Rails 3 has a bug and does not start in any environment but development for now.
    (if rinari-rails-env
        (setq command (concat command " -e " rinari-rails-env)))

    ;; For customization of the web server command with prefix arg.
    (setq command (if edit-cmd-args
                      (read-string "Run Ruby: " (concat command " "))
                    command))

    (gusev-shell-run default-directory command "*server*"))
  (rinari-launch))


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
(setq sql-sqlite-program "sqlite3")

;; ERC
(require 'emacs-rc-erc)

;; ANSI colors
(require 'ansi-color)
(setq ansi-color-names-vector
      ["black" "red" "green" "yellow" "LightSkyBlue" "magenta" "cyan" "white"])
(setq ansi-color-map (ansi-color-make-color-map))

(require 'emacs-rc-tty-format)

;; el4r
;; (with-demoted-errors
;;   (require 'emacs-rc-el4r))

;; Anything
(require 'emacs-rc-anything)

;; Jabber
(add-to-list 'load-path (concat (getenv "HOME")
                               "/.emacs.d/site-lisp/emacs-jabber-0.8.0"))

;; ditz
(require 'ditz)

;; EMMS
;; (require 'emacs-rc-emms)

;; C#
(require 'csharp-mode)

;; magit
(require 'magit)

;; twitter
;; (require 'twit)

;; Emacswiki
(require 'yaoddmuse)

;; http://www.emacswiki.org/emacs/ToggleWindowSplit
(require 'toggle-window-split)

(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/site-lisp")

;; Yasnippet
(require 'yasnippet)
(setq yas/snippet-dirs "~/.emacs.d/site-lisp/yasnippet-snippets")
(yas/load-snippet-dirs)
(yas/global-mode t)

;; nXhtml
(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; This prevents activating nxhtml-mode for .html.haml files.
(add-to-list 'auto-mode-alist '("\\.html\\.haml$" . haml-mode))


(setq aug-secret-file "~/.emacs.d/.secret-file")
(load aug-secret-file t)

;;
;; Emacs core customization
;;

;; EShell
(require 'emacs-rc-eshell)

;; Spelling
(setq ispell-dictionary "en_US")

;; Filladapt
(setq-default filladapt-mode t)

(require 'emacs-rc-compilation)

;; comint-mode
(setq comint-scroll-to-bottom-on-output 'others)
;; for zsh extended history...
(setq comint-input-ring-separator "\\(\n\\|:[[:space:]]+[[:digit:]]+:[[:digit:]]+;\\)")

(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

(require 'emacs-rc-shell)

;; Org-mode
(require 'emacs-rc-org)

(setq large-file-warning-threshold 30000000)

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
(require 'emacs-rc-ldap nil t)
(require 'emacs-rc-view)
(require 'emacs-rc-bbdb nil t)

(electric-pair-mode)
;; Does not work good in cucumber mode and haml.
(electric-layout-mode)
(electric-indent-mode)

(require 'emacs-rc-user-info)
(require 'emacs-rc-kbd)

;; Everything else...
;; FIXME: When I do yank on selected region yanked test does not appear.
(require 'emacs-rc-misc-things)

(setq flyspell-use-meta-tab nil)

(require 'hideshow)
(setq hs-allow-nesting t)

(defun hs-gau-hide-level-deeply (arg)
  "Hide all blocks deeper that ARG level below the top of file."
  (interactive "p")
  (let* ((max-level 5)
         (level-to-hide max-level))
    (save-excursion
      (goto-char (point-min))
      (hs-show-all)
      (while (>= level-to-hide arg)
	(save-excursion
          (hs-hide-level level-to-hide)
          (setq level-to-hide (1- level-to-hide)))))))

(defun hs-gau-toggle-hiding-or-hide-level (level)
  (interactive "P")
  (if level
      (hs-gau-hide-level-deeply level)
    (hs-toggle-hiding)))


(add-hook 'hs-minor-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-tab>") 'hs-gau-toggle-hiding-or-hide-level)))

;; Color theme loading, must be the last.
(load-library "color-themes/color-theme-dark-hron")
(color-theme-dark-hron)

;;; ~/.emacs.d/init.el

;; Copyright (C) 2004, 2005, 2006,
;;               2007, 2008, 2009 Aleksei Gusev <aleksei.gusev@gmail.com>

;; Started: 1 June 2004
;; Version: $Id$


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
             '("melpa" . "http://melpa.milkbox.net/packages/")
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(require 'server)

;;----------------------------------------------------------------------------
;; Handier way to add modes to auto-mode-alist
;;----------------------------------------------------------------------------
(defun add-auto-mode (mode &rest patterns)
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

(require 'expand-region)
(eval-after-load "org"     '(require 'org-mode-expansions))
(global-set-key (kbd "M-h") 'er/expand-region)
(global-set-key (kbd "M-j") 'er/contract-region)

(add-to-list 'er/try-expand-list 'mark-paragraph)

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
(autoload 'git-blame-mode "git-blame" "Minor mode for incremental blame for Git." t)

;; Ruby
(require 'emacs-rc-ruby)

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

;; ANSI colors
(require 'ansi-color)
(setq ansi-color-names-vector
      ["black" "#B21818" "#18B218" "#B26818" "#1818B2" "#B218B2" "#18B2B2" "#B2B2B2"])
(setq ansi-color-map (ansi-color-make-color-map))

(require 'emacs-rc-tty-format)

;; Helm
(require 'emacs-rc-helm)

;; Projectile
(require 'emacs-rc-projectile)

;; magit
(require 'magit)
(add-hook 'magit-log-edit-mode-hook
          '(lambda () (set-fill-column 70)))
(setq magit-status-buffer-switch-function 'switch-to-buffer)

;; http://www.emacswiki.org/emacs/ToggleWindowSplit
(require 'toggle-window-split)

;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; ;; nXhtml
;; (load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; ;; This prevents activating nxhtml-mode for .html.haml files.
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo-mode))
;; (add-to-list 'auto-mode-alist '("\\.html\\.haml\\'" . haml-mode))

(setq aug-secret-file "~/.emacs.d/.secret-file")
(load aug-secret-file t)

;; Coffescript
(setq coffee-tab-width 2)
(add-hook 'coffee-mode-hook '(lambda ()
                               (make-variable-buffer-local 'electric-indent-chars)
                               (setq electric-indent-chars '())
                               (define-key coffee-mode-map (kbd "C-c C-s") 'coffee-repl)))
(add-auto-mode 'coffee-mode "\.coffee\.erb$")

(add-auto-mode 'nginx-mode "nginx.conf$")


(add-hook 'feature-mode-hook '(lambda ()
                               (make-variable-buffer-local 'electric-indent-chars)
                               (setq electric-indent-chars '())))

;; (require 'ibus)
;; (global-set-key (kbd "S-<delete>") 'ibus-toggle)
;; (global-set-key (kbd "S-<return>") 'ibus-toggle)
;; ;; Use C-SPC for Set Mark command
;; (ibus-define-common-key ?\C-\s nil)
;; ;; Use C-/ for Undo command
;; (ibus-define-common-key ?\C-/ nil)
;; (ibus-mode-on)

;; This is autoinsert template for Real World Haskell exercises
(require 'autoinsert)
(add-to-list 'auto-insert-alist
             '(("real-world-haskell/.*\\.hs$" . "Exercise from 'Real World Haskell'")
               nil
               "

import Test.HUnit

tests = []

main = do
  runTestTT $ TestList tests
"
             ))

;; Javascript
(add-hook 'js-mode-hook '(lambda () (setq indent-tabs-mode nil)))

;; Cucumber.el
(add-hook 'feature-mode-hook 'turn-on-flyspell)

;; Sass mode
(add-hook 'sass-mode-hook '(lambda ()
                             (setq indent-tabs-mode nil)))
(add-hook 'scss-mode-hook '(lambda ()
                             (setq indent-tabs-mode nil)))

;;
;; Emacs core customization
;;

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

(setq large-file-warning-threshold 30000000)

(require 'emacs-rc-flymake)
(require 'emacs-rc-ido)
(require 'emacs-rc-decor)
(require 'emacs-rc-dired)
(require 'emacs-rc-hippie-exp)
(require 'emacs-rc-gdb)
;; BUG: Tramp sudo does not work with this hack.
;; (require 'emacs-rc-mule)
(require 'emacs-rc-tramp)
(require 'emacs-rc-woman)
(require 'emacs-rc-view)


;; (electric-pair-mode)
(electric-layout-mode)
(electric-indent-mode)

(require 'emacs-rc-user-info)
(require 'emacs-rc-kbd)

;; Everything else...
;; FIXME: When I do yank on selected region yanked test does not appear.
(require 'emacs-rc-misc-things)

(setq flyspell-use-meta-tab nil)

(require 'desktop)
(add-hook 'desktop-before-save-hook 'clean-buffer-list)
(put 'narrow-to-region 'disabled nil)

(setq default-frame-alist '((width . 95) (height . 100) (vertical-scroll-bars)))

;; Color theme choosing
(load-theme 'solarized-light t)

;; (set-face-attribute 'default nil :font "Ubuntu Mono")
;; (set-face-attribute 'variable-pitch nil :font "Ubuntu")

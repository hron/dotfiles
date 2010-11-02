;;; emacs-rc-ruby.el --- Ruby-mode customization.

;; Copyright (C) 2007, 2008  Warecorp

;; Author: Aleksei Gusev <aleksei.gusev@warecorp.com>
;; Keywords:

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;

;;; Code:

;;; ruby-mode site-lisp configuration

(add-auto-mode 'ruby-mode
               "\\.rb$" "\.rake$" "\.rxml$" "\.rjs"
               ".irbrc" "\.builder" "\.gemspec"
               "Rakefile$" "Capfile" "Gemfile" "Sitefile"
               "Vagrantfile" "\\.autotest$"
               "\\.watchr")

(add-hook 'ruby-mode-hook
          '(lambda ()
             (auto-fill-mode 1)
             (flyspell-prog-mode)
             (setq fill-column 100)
             (setq indent-tabs-mode nil)
             ;; (turn-on-orgstruct)
             ;; (turn-on-orgtbl)
             (highlight-parentheses-mode 1)))

(setq ruby-deep-indent-paren '(?\( t))

;; Inferion ruby
(require 'inf-ruby)
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'ruby-mode-hook 'inf-ruby-keys)

;; these aliases is for emacs-rails-reloaded.
(defalias 'inferior-ruby-mode 'inf-ruby-mode)
(defalias 'inferior-ruby-first-prompt-pattern 'inf-ruby-first-prompt-pattern)
(defalias 'inferior-ruby-prompt-pattern 'inf-ruby-prompt-pattern)

;; yari
(defun yari-bind-key ()
  (local-set-key [f1] 'yari-anything))

(defalias 'rails-search-doc 'yari)
(add-hook 'ruby-mode-hook 'yari-bind-key)
(add-hook 'rhtml-mode-hook 'yari-bind-key)
(add-hook 'haml-mode-hook 'yari-bind-key)
(add-hook 'sass-mode-hook 'yari-bind-key)

;; ruby-compilation
;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (if (string-match "Capfile\\|deploy.rb" (buffer-file-name))
;;                  (local-set-key [f9] 'ruby-compilation-cap)
;;                (local-set-key [f9] 'ruby-compilation-rake))))

;; emacs-rails-reloaded
(setq-default rails/bundles/disabled-list '(apidock))
(setq rails/webserver-bundle/default-type "webrick")

;;----------------------------------------------------------------------------
;; Ruby - flymake
;;----------------------------------------------------------------------------
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook '(lambda ()
                             (condition-case err
                                 (flymake-ruby-load)
                               (error (unless (string= "Invalid file-name" (cadr err))
					(error err))))))

;;----------------------------------------------------------------------------
;; Ruby - Electric mode
;;----------------------------------------------------------------------------
;; (autoload 'ruby-electric-mode "ruby-electric" "Electric brackes/quotes/keywords for Ruby source" t)
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (unless (string= major-mode "el4r-mode")
;;               (ruby-electric-mode t))))

;;----------------------------------------------------------------------------
;; Ruby - haml & sass
;;----------------------------------------------------------------------------
(add-auto-mode 'haml-mode "\.haml$")
(add-auto-mode 'sass-mode "\.sass$")
(autoload 'haml-mode "haml-mode" "Mode for editing haml files" t)
(autoload 'sass-mode "sass-mode" "Mode for editing sass files" t)

(require 'flymake-haml)
(add-hook 'haml-mode-hook 'flymake-haml-load)
(add-hook 'sass-mode-hook 'flymake-sass-load)

(add-auto-mode 'rhtml-mode "\.erb$")

(require 'rdebug)
(add-hook 'comint-mode-hook 'turn-on-rdebug-track-mode)

;; Add binding to insert ruby debugger with F7.
(defun GAU-insert-ruby-debug ()
  (interactive)
  (let ((ruby-debug-string "require 'ruby-debug'; debugger; stop_here = 1;\n"))
    (insert ruby-debug-string))
  (previous-line)
  (ruby-indent-line))

(defun GAU-bind-insert-ruby-debug-key ()
  (local-set-key [f7] 'GAU-insert-ruby-debug))

(add-hook 'ruby-mode-hook 'GAU-bind-insert-ruby-debug-key)

(require 'feature-mode)

(require 'autotest)
(setq autotest-command "export AUTOFEATURE=true; autospec")

(defun watchr (script)
  "*Run watchr in autotest mode for SCRIPT."
  (interactive "fWatchr script: ")
  (let* ((buffer-name (concat "*watchr*<" (file-name-nondirectory script) ">"))
	 (buffer (shell buffer-name)))
    (shell-cd (file-name-directory script))
    (comint-send-string buffer (concat "watchr " script "\n"))))

;; rvm stuff
(add-auto-mode 'compilation-mode
               "\.rvm/log/.*/\\(autoconf\\|configure\\|make\\).*\.log")

;; Ruby test mode
;; (require 'ruby-test-mode)
;; (add-hook 'ruby-mode-hook 'ruby-test-mode)

(require 'hideshow)
(add-to-list 'hs-special-modes-alist
	     '(ruby-mode
	       "\\(def\\|do\\|{\\)" "\\(end\\|end\\|}\\)" "#"
	       (lambda (arg) (ruby-end-of-block)) nil))
(add-hook 'ruby-mode-hook '(lambda ()
			     (hs-minor-mode)
			     (when (string-match "spec\.rb$" filename)
			       (hs-hide-level 2))))

(provide 'emacs-rc-ruby)
;;; emacs-rc-ruby.el ends here

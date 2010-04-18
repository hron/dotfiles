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

(setq ruby-deep-indent-paren '())

;; Inferion ruby
(require 'inf-ruby)
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

(defalias 'inferior-ruby-mode 'inf-ruby-mode)
(defalias 'inferior-ruby-first-prompt-pattern 'inf-ruby-first-prompt-pattern)
(defalias 'inferior-ruby-prompt-pattern 'inf-ruby-prompt-pattern)
(add-hook 'ruby-mode-hook 'inf-ruby-keys)

(setq inf-ruby-first-prompt-pattern "^>> *"
      inf-ruby-prompt-pattern "^>> *")



;; Ri-Emacs
;; (setq ri-ruby-progres "/usr/bin/ruby")
;; (setq ri-ruby-script (concat (getenv "HOME") "/.emacs.d/site-lisp/ri-emacs/ri-emacs.rb"))
;; (autoload 'ri "~/.emacs.d/site-lisp/ri-emacs/ri-ruby.el" nil t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/ri.el"))
(require 'ri)
(defun ri-bind-key ()
  (local-set-key [f1] 'ri))

(defalias 'rails-search-doc 'ri)

(add-hook 'ruby-mode-hook 'ri-bind-key)
(add-hook 'rhtml-mode-hook 'ri-bind-key)
(add-hook 'haml-mode-hook 'ri-bind-key)
(add-hook 'sass-mode-hook 'ri-bind-key)

;; ruby-compilation
;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (if (string-match "Capfile\\|deploy.rb" (buffer-file-name))
;;                  (local-set-key [f9] 'ruby-compilation-cap)
;;                (local-set-key [f9] 'ruby-compilation-rake))))

;; emacs-rails-reloaded
(setq-default rails/bundles/disabled-list '(apidock))

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
(autoload 'ruby-electric-mode "ruby-electric" "Electric brackes/quotes/keywords for Ruby source" t)
(add-hook 'ruby-mode-hook
          (lambda ()
            (unless (string= major-mode "el4r-mode")
              (ruby-electric-mode t))))

;;----------------------------------------------------------------------------
;; Ruby - haml & sass
;;----------------------------------------------------------------------------
(add-auto-mode 'haml-mode "\.haml$")
(add-auto-mode 'sass-mode "\.sass$")
(autoload 'haml-mode "haml-mode" "Mode for editing haml files" t)
(autoload 'sass-mode "sass-mode" "Mode for editing sass files" t)
(add-hook 'haml-mode-hook 'ri-bind-key)
(add-hook 'sass-mode-hook 'ri-bind-key)

(require 'flymake-haml)
(add-hook 'haml-mode-hook 'flymake-haml-load)
(add-hook 'sass-mode-hook 'flymake-sass-load)

(add-auto-mode 'rhtml-mode "\.erb$")

(require 'rdebug)
(add-hook 'comint-mode-hook 'turn-on-rdebug-track-mode)

(require 'feature-mode)

(require 'autotest)
(setq autotest-command "export AUTOFEATURE=true; autospec")

(provide 'emacs-rc-ruby)
;;; emacs-rc-ruby.el ends here

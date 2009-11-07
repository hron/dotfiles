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
	       "\\.rb$" "Rakefile$" "Capfile" "\.rake$"
	       "\.rxml$" "\.rjs" ".irbrc" "\.builder")

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (auto-fill-mode 1)
	     (flyspell-prog-mode)
	     (setq fill-column 100)
	     ;; (turn-on-orgstruct)
	     ;; (turn-on-orgtbl)
	     (highlight-parentheses-mode 1)))

;; Inferion ruby
(defalias 'inferior-ruby-mode 'inf-ruby-mode)
(defalias 'inferior-ruby-first-prompt-pattern 'inf-ruby-first-prompt-pattern)
(defalias 'inferior-ruby-prompt-pattern 'inf-ruby-prompt-pattern)
(add-hook 'ruby-mode-hook 'inf-ruby-keys)

;; Ri-Emacs
(setq ri-ruby-progres "/usr/bin/ruby")
(setq ri-ruby-script (concat (getenv "HOME") "/.emacs.d/site-lisp/ri-emacs/ri-emacs.rb"))
(autoload 'ri "~/.emacs.d/site-lisp/ri-emacs/ri-ruby.el" nil t)

(defalias 'rails-search-doc 'ri)

(add-hook 'ruby-mode-hook
	  (lambda ()
	    (local-set-key [f1] 'ri)))

;; ruby-compilation
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (if (string-match "Capfile" (buffer-file-name))
		 (local-set-key [f9] 'ruby-compilation-cap)
	       (local-set-key [f9] 'ruby-compilation-rake))))

;;----------------------------------------------------------------------------
;; Ruby - flymake
;;----------------------------------------------------------------------------
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;;----------------------------------------------------------------------------
;; Ruby - Electric mode
;;----------------------------------------------------------------------------
(autoload 'ruby-electric-mode "ruby-electric" "Electric brackes/quotes/keywords for Ruby source" t)
(add-hook 'ruby-mode-hook
          (lambda () (ruby-electric-mode t)))

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

(require 'rdebug)

(provide 'emacs-rc-ruby)
;;; emacs-rc-ruby.el ends here

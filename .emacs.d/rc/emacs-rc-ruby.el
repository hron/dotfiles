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
	     (turn-on-orgstruct)
	     (turn-on-orgtbl)
	     (highlight-parentheses-mode 1)))

;; Inferion ruby
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

(add-hook 'ruby-mode-hook 'inf-ruby-keys)

;; Ri-Emacs
(setq ri-ruby-progres "/usr/bin/ruby")
(setq ri-ruby-script (concat (getenv "HOME") "/.emacs.d/site-lisp/ri-emacs/ri-emacs.rb"))
(autoload 'ri "~/.emacs.d/site-lisp/ri-emacs/ri-ruby.el" nil t)

(defalias 'rails-search-doc 'ri)

(add-hook 'ruby-mode-hook
	  (lambda ()
	    (local-set-key [f1] 'ri)))

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

(provide 'emacs-rc-ruby)
;;; emacs-rc-ruby.el ends here

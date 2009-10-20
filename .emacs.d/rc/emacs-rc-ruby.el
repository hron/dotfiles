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

(add-to-list 'auto-mode-alist
						 '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist
						 '("Capfile" . ruby-mode))

(add-hook 'ruby-mode-hook
					'(lambda ()
						 (auto-fill-mode 1)))

;; Ri-Emacs
(setq ri-ruby-progres "/usr/bin/ruby")
(setq ri-ruby-script (concat (getenv "HOME") "/.emacs.d/site-lisp/ri-emacs/ri-emacs.rb"))
(autoload 'ri "~/.emacs.d/site-lisp/ri-emacs/ri-ruby.el" nil t)

(defalias 'rails-search-doc 'ri)

(add-hook 'ruby-mode-hook
					(lambda ()
						(local-set-key [f1] 'ri)))


(provide 'emacs-rc-ruby)

;;; emacs-rc-ruby.el ends here

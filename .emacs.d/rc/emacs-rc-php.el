;;;emacs-rc-php.el --- php-mode customization

;; Copyright (C) 2007, 2008  Aleksei Gusev <aleksei.gusev@gmail.com>

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: 11 Апр 2007
;; Version: $Id$
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
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; 

;;; Code:

(add-to-list 'load-path
						 (expand-file-name "~/.emacs.d/site-lisp/php_repl/data"))

(require 'php-mode)

(setq php-manual-path "/usr/share/doc/php-docs-20071125-r2/ru"
      php-manual-url (concat "file://" php-manual-path))

(add-hook 'php-mode-hook '(lambda ()
			    (progn
			      (c-toggle-auto-newline -1)
			      (setq c-basic-offset 4
				    indent-tabs-mode nil))))

(require 'php-repl)
(setq php-repl-program (concat (getenv "HOME") "/pear/php-repl"))

(require 'phpunit)
;; Make clickalabe of standard PHP fatals too.
(setq phpunit-regexp-alist (append phpunit-regexp-alist
																	 '(php)))

(require 'flymake-php)
(add-hook 'php-mode-hook '(lambda () (flymake-mode t)))

(require 'php-electric)
(add-hook 'php-mode-hook '(lambda () (php-electric-mode)))

(require 'smarty-mode)
(add-to-list 'auto-mode-alist
						 '( "\\.tpl" . smarty-mode))

(autoload 'geben "geben" "PHP Debugger on Emacs" t)

(provide 'emacs-rc-php)
;;; emacs-rc-php.el ends here

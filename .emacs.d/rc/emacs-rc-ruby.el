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

(add-hook 'ruby-mode-hook 'inf-ruby-keys)

(add-hook 'ruby-mode-hook (lambda ()
                            (ruby-electric-mode 1)
			    (inf-ruby-keys)
                            (local-set-key [f1] 'ri)
			    (local-set-key [?\C->] 'rct-complete-symbol--anything)))

;; (add-hook 'ruby-mode-hook (lambda ()
;;                             (local-set-key 'f1 'ri)
;;                             (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
;;                             (local-set-key 'f4 'ri-ruby-show-args)
;;                             ))

;;; emacs-rc-ruby.el ends here

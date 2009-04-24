;;; emacs-rc-ri.el --- Ri for Emacs customization.

;; Copyright (C) 2007  Warecorp

;; Author: Aleksei Gusev <aleksei.gusev@warecorp.com>
;; Keywords:

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
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

(setq ri-ruby-progres "/usr/bin/ruby")
(setq ri-ruby-script (concat (getenv "HOME") "/.emacs.d/packages/ri-emacs/ri-emacs.rb"))
(autoload 'ri "~/.emacs.d/packages/ri-emacs/ri-ruby.el" nil t)

(defalias 'rails-search-doc 'ri)

;; (add-hook 'ruby-mode-hook (lambda ()
;;                             (local-set-key [f1] 'ri)
;;                             (local-set-key "\M-\S-i" 'ri-ruby-complete-symbol)
;;                             (local-set-key [f3] 'ri-ruby-show-args)
;;                             ))

;; (add-hook 'html-mode-hook (lambda ()
;;                             (if (string-match (symbol-name major-mode) "rhtml-mode")
;;                                 (local-set-key [f1] 'ri))))
;;; emacs-rc-ri.el ends here

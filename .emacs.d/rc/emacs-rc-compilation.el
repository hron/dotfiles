;;; emacs-rc-compilation.el --- compilation-mode customization.

;; Copyright (C) 2010  Aleksei Gusev

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'compile)
;; (setq compilation-error-regexp-alist '())

(setq compilation-error-regexp-alist
      (mapcar 'car compilation-error-regexp-alist-alist))

(let ((compilation-regexps
       '((ruby
	  "^[\t ]*\\(?:from \\)?\\([^\(\n][^[:space:]\n]*\\):\\([1-9][0-9]*\\)\\(:in `.*'\\)?.*$" 1 2)
	 (ruby-Test::Unit
	  "[\t ]*\\[\\([^\(].*\\):\\([1-9][0-9]*\\)\\(\\]\\)?:" 1 2)
	 (rspec
	  "\\(?:^rspec\\(?: -p [^[:space:]]+\\)?\\|#\\)\\(?: \\)\\([^\(].*\\):\\([1-9][0-9]*\\)" 1 2)
	 (cucumber
	  "\\(?:^cucumber\\(?: -p [^[:space:]]+\\)?\\|#\\)\\(?: \\)\\([^\(].*\\):\\([1-9][0-9]*\\)" 1 2))))
  (dolist (regexp compilation-regexps)
    (add-to-list 'compilation-error-regexp-alist (cdr regexp) t)))

(add-hook 'compilation-mode-hook
	  '(lambda ()
	     (local-set-key "\C-cg" 'rgrep)))

(provide 'emacs-rc-compilation)
;;; emacs-rc-compilation.el ends here

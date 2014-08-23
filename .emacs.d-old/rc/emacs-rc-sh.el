;;; emacs-rc-sh.el --- Shell customization.

;; Copyright (C) 2009  Aleksei Gusev

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

(add-auto-mode 'sh-mode
	       "\\.rvmrc$"
	       "/etc/conf.d/"
	       "\\.verb"
	       "/etc/init/")


(add-hook 'sh-mode-hook '(lambda ()
                           (turn-on-auto-fill)
                           (flyspell-prog-mode)
                           (highlight-parentheses-mode 1)))

;; Automatically set execute perms on files if first line begins with '#!'
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(autoload 'flymake-shell-load "flymake-shell"
  "On-the-fly syntax checking of shell scripts" t)
(add-hook 'sh-mode-hook '(lambda ()
                           (unless (tramp-tramp-file-p (buffer-file-name))
                             (flymake-shell-load))))

(provide 'emacs-rc-sh)
;;; emacs-rc-sh.el ends here

;;; emacs-rc-eshell.el --- eshell customization

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

(require 'eshell)


(require 'em-term)
(setq eshell-term-name "eterm-color")

(mapc '(lambda (command) (add-to-list 'eshell-visual-commands command))
      '("htop" "iotop"))

(add-hook 'eshell-mode-hook 'turn-on-eldoc-mode)

(defun eshell/watchr (&rest args)	; all but first ignored
  "Alias to call list watchr inside eshell"
  (let ((script (car args)))
    (watchr script)))

(setq eshell-banner-message
      '(concat
	"Welcome to Eshell!\n"
	"  ruby: " (shell-command-to-string
                    "ruby --version 2>/dev/null || echo 'no ruby... :('")
	"  gems: " (shell-command-to-string
                    "gem --version 2>/dev/null || echo 'no rubygems... :('")))

(setq eshell-output-filter-functions
      '(eshell-postoutput-scroll-to-bottom
	eshell-handle-control-codes
	eshell-handle-ansi-color
	eshell-watch-for-password-prompt))

(provide 'emacs-rc-eshell)
;;; emacs-rc-eshell.el ends here

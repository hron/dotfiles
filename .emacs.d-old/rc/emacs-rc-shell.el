;;; emacs-rc-shell.el --- shell mode customization.

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

;; (require 'shell)

(defun add-header-line-dirtrack ()
  (setq header-line-format
	'(:propertize (" " default-directory " ") face dired-directory)))

(add-hook 'shell-mode-hook 'add-header-line-dirtrack)

(defun gusev-clear-shell ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(add-hook 'shell-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-M-x") 'gusev-clear-shell)))
;; (define-key 'shell-mode-map (kbd "C-c q") 'gusev-clear-shell)

;; Disable echoing of run commands.
(add-hook 'shell-mode-hook
          (lambda ()
            (setq comint-process-echoes 't)))

(provide 'emacs-rc-shell)
;;; emacs-rc-shell.el ends here

;;; emacs-rc-view.el --- view-mode customization.

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

;; This function moves keybinding of view-mode to top to ensure we
;; have no overriding some of them by other minor modes, which is very
;; annoying at least for me. 
(defun gau-move-view-mode-keymap-on-top ()
  (setq minor-mode-map-alist
	(sort minor-mode-map-alist '(lambda (a b)
				      (if (eq (car a) 'view-mode)
					  t
					nil)))))

(add-hook 'view-mode-hook 'gau-move-view-mode-keymap-on-top)

(provide 'emacs-rc-view)
;;; emacs-rc-view.el ends here

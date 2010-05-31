;;; emacs-rc-ibus.el --- iBus customization.

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

(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
;; (ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
;; (ibus-define-common-key ?\C-/ nil)
;; Change cursor color depending on IBus status
;; (setq ibus-cursor-color '("red" "blue" "limegreen"))


(provide 'emacs-rc-ibus)
;;; emacs-rc-ibus.el ends here

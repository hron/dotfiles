;;; emacs-rc-projectile.el ---

;; Copyright (C) 2013  Aleksei Gusev

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

(setq projectile-rails-keymap-prefix (kbd "C-c l"))
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(add-hook 'projectile-mode-hook '(lambda ()
                                   (local-set-key (kbd "C-c t")
                                                  'projectile-toggle-between-implementation-and-test)))
(projectile-global-on)

(provide 'emacs-rc-projectile)
;;; emacs-rc-projectile.el ends here

;;; emacs-rc-anything.el --- anything.el customization.

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

(require 'anything)
(require 'anything-config)
(require 'yari)
;; (require 'anything-git-grep)
(require 'anything-git)

;; (add-hook 'anything-after-initialize-hook
;;           '(lambda ()
;;              (local-set-key "M-}" 'anything-next-source)
;;              (local-set-key "M-{" 'anything-prev-source)))

;; (global-set-key (kbd "M-C-5") 'anything-query-replace-regexp)
(setq anything-sources
      '(anything-c-source-imenu
	anything-c-source-buffers+
	;; anything-c-source-git-grep
	;; anything-c-source-git-submodule-grep
	anything-c-source-git-files
	anything-c-source-git-grep
	anything-c-source-recentf
	yari-anything-source-ri-pages
	anything-c-source-files-in-current-dir+))

(define-key anything-map (kbd "M-RET") 'anything-execute-persistent-action)

(global-set-key (kbd "S-SPC") 'anything)

(provide 'emacs-rc-anything)
;;; emacs-rc-anything.el ends here

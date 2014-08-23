;;; emacs-rc-helm.el --- helm.el customization.

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

(require 'helm)
(require 'helm-config)
(require 'helm-projectile)
(require 'helm-imenu)

(setq projectile-require-project-root nil)

(setq helm-buffer-max-length 40)

(setq helm-sources-using-default-as-input '())

;;;###autoload
(defun gus-helm ()
  "Preconfigured `helm' lightweight version \(buffer -> recentf\)."
  (interactive)
  (require 'helm-files)
  (helm-other-buffer '(helm-source-imenu
                       helm-source-buffers-list
                       helm-source-projectile-files-list
                       helm-source-recentf
                       helm-source-buffer-not-found)
                     "*helm mini*"))

(define-key helm-map (kbd "M-RET") 'helm-execute-persistent-action)

(global-set-key (kbd "S-SPC") 'gus-helm)
;; (helm-mode 1)

(add-hook 'dired-mode-hook '(lambda ()
                              (local-set-key (kbd "S-SPC") 'gus-helm)))
(add-hook 'view-mode-hook '(lambda ()
                              (local-set-key (kbd "S-SPC") 'gus-helm)))

(provide 'emacs-rc-helm)
;;; emacs-rc-helm.el ends here

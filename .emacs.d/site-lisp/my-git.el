;;; my-git.el ---

;; Copyright (C) 2011  Aleksei Gusev

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

(require 'vc-git)

(defun my-git-toplevel ()
  (vc-git-root (file-truename (if (buffer-file-name)
                                  (file-name-directory (buffer-file-name))
                                default-directory))))

;; return git toplevel of root project
(defun my-git-root ()
  (flet ((iter (path)
               (let ((p (and path (vc-git-root path))))
                 (or (and p (iter (my-parent-directory p))) p))))
    (iter (file-truename (if (buffer-file-name)
                             (file-name-directory (buffer-file-name))
                           default-directory)))))

(defun my-parent-directory (path)
  (let ((parent (file-name-directory (directory-file-name (file-name-directory path)))))
    (if (string-equal parent path) nil parent)))

(defvar my-current-git-toplevel nil)
(make-variable-buffer-local 'my-current-git-toplevel)
(defvar my-current-git-root nil)
(make-variable-buffer-local 'my-current-git-root)
(defun my-current-git-toplevel ()
  (or my-current-git-toplevel
    (setq my-current-git-toplevel (my-git-toplevel))))
(defun my-current-git-root ()
  (or my-current-git-root
    (setq my-current-git-root (my-git-root))))

(provide 'my-git)
;;; my-git.el ends here

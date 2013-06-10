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

(require 'projectile)

(defun projectile-project-files (directory)
  "List the files in DIRECTORY and in its sub-directories.
Files are returned as relative paths to the project root."
  ;; check for a cache hit first if caching is enabled
  (let ((files-list (and projectile-enable-caching
			 (gethash directory projectile-projects-cache)))
	(root (projectile-project-root)))
    ;; cache disabled or cache miss
    (unless files-list
      (if projectile-use-native-indexing
	  (progn
	    (message "Projectile is indexing %s. This may take a while."
		     (propertize directory 'face 'font-lock-keyword-face))
	    (setq files-list
		  ;; we need the files with paths relative to the project root
		  (-map (lambda (file) (s-chop-prefix root file))
			(projectile-index-directory directory (projectile-patterns-to-ignore)))))
	;; use external tools to get the project files
	(let ((current-dir (if (buffer-file-name)
			       (file-name-directory (buffer-file-name))
			     default-directory)))
	  (cd root)
	  (setq files-list (-map (lambda (f)
				   (s-chop-prefix root f))
				 (projectile-get-repo-files)))
	  ;; restore the original current directory
	  (message current-dir)
	  (cd current-dir))))
    files-list))

(provide 'emacs-rc-projectile)
;;; emacs-rc-projectile.el ends here

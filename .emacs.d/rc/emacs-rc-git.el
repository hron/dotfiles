;;; emacs-rc-git.el --- customization related to Git.

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

(autoload 'git-blame-mode "git-blame" "Minor mode for incremental blame for Git." t)

;;----------------------------------------------------------------------------
;; git-svn conveniences
;;----------------------------------------------------------------------------
(eval-after-load "compile"
  '(progn
     (mapcar (lambda (defn) (add-to-list 'compilation-error-regexp-alist-alist defn))
             (list '(git-svn-updated "^\t[A-Z]\t\\(.*\\)$" 1 nil nil 0 1)
                   '(git-svn-needs-update "^\\(.*\\): needs update$" 1 nil nil 2 1)))
     (mapcar (lambda (defn) (add-to-list 'compilation-error-regexp-alist defn))
             (list 'git-svn-updated 'git-svn-needs-update))))

(defun git-svn (dir)
  (interactive "DSelect directory: ")
  (let* ((default-directory (git-get-top-dir dir))
         (compilation-buffer-name-function (lambda (major-mode-name) "*git-svn*")))
    (compile (concat "git svn "
                     (ido-completing-read "git-svn command: "
                                          (list "rebase" "dcommit" "fetch" "log") nil t)))))


(provide 'emacs-rc-git)
;;; emacs-rc-git.el ends here

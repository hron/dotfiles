;;; emacs-rc-compilation.el --- compilation-mode customization.

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

(require 'compile)
;; (setq compilation-error-regexp-alist '())

(setq compilation-error-regexp-alist
      (mapcar 'car compilation-error-regexp-alist-alist))

(let ((compilation-regexps
       '((ruby
       "^[\t ]*\\(?:from \\)?\\([^\(\n][^[:space:]\n]*\\):\\([1-9][0-9]*\\)\\(:in `.*'\\)?.*$" 1 2)
      (ruby-Test::Unit
       "[\t ]*\\[\\([^\(].*\\):\\([1-9][0-9]*\\)\\(\\]\\)?:" 1 2)
      (rspec
       "\\(?:^rspec\\(?: -p [^[:space:]]+\\)?\\|#\\)\\(?: \\)\\([^\(].*\\):\\([1-9][0-9]*\\)" 1 2)
      (cucumber
       "\\(?:^cucumber\\(?: -p [^[:space:]]+\\)?\\|#\\)\\(?: \\)\\([^\(].*\\):\\([1-9][0-9]*\\)" 1 2))))
  (dolist (regexp compilation-regexps)
    (add-to-list 'compilation-error-regexp-alist (cdr regexp) t)))

(add-hook 'compilation-mode-hook
          '(lambda ()
             (local-set-key "\C-cg" 'rgrep)))

;; This is a redefined version of `compilation-next-error-function' which
;; doesn't use markers at all. In other words is a hack for guard buffers.
(defun compilation-next-error-function (n &optional reset)
  "Advance to the next error message and visit the file where the error was.
This is the value of `next-error-function' in Compilation buffers."
  (interactive "p")
  (when reset
    (setq compilation-current-error nil))
  (let* ((screen-columns compilation-error-screen-columns)
         (first-column compilation-first-column)
         (last 1)
         (msg (compilation-next-error (or n 1) nil
                                      (or compilation-current-error
                                          compilation-messages-start
                                          (point-min))))
         (loc (compilation--message->loc msg))
         (end-loc (compilation--message->end-loc msg))
         (marker (point-marker)))
    (setq compilation-current-error (point-marker)
          overlay-arrow-position
            (if (bolp)
		compilation-current-error
              (copy-marker (line-beginning-position))))
    (with-current-buffer
	(compilation-find-file
         marker
         (caar (compilation--loc->file-struct loc))
         (cadr (car (compilation--loc->file-struct loc))))
      (let ((screen-columns
             ;; Obey the compilation-error-screen-columns of the target
             ;; buffer if its major mode set it buffer-locally.
             (if (local-variable-p 'compilation-error-screen-columns)
                 compilation-error-screen-columns screen-columns))
            (compilation-first-column
             (if (local-variable-p 'compilation-first-column)
                 compilation-first-column first-column)))
	(save-restriction
          (widen)
          (goto-char (point-min))
          ;; Treat file's found lines in forward order, 1 by 1.
          (dolist (line (reverse (cddr (compilation--loc->file-struct loc))))
            (when (car line)		; else this is a filename w/o a line#
              (beginning-of-line (- (car line) last -1))
              (setq last (car line)))
            ;; Treat line's found columns and store/update a marker for each.
            (dolist (col (cdr line))
              (if (compilation--loc->col col)
                  (if (eq (compilation--loc->col col) -1)
                      ;; Special case for range end.
                      (end-of-line)
                    (compilation-move-to-column (compilation--loc->col col)
						screen-columns))
		(beginning-of-line)
		(skip-chars-forward " \t"))
              (if (compilation--loc->marker col)
                  (set-marker (compilation--loc->marker col) (point))
		(setf (compilation--loc->marker col) (point-marker)))
              ;; (setf (compilation--loc->timestamp col) timestamp)
              )))))
    (compilation-goto-locus marker (compilation--loc->marker loc)
                            (compilation--loc->marker end-loc))
    (setf (compilation--loc->visited loc) t)))

(provide 'emacs-rc-compilation)
;;; emacs-rc-compilation.el ends here

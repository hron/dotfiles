;;; nerd-icons-grep.el --- Add nerd-icons to grep-mode -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: May 07, 2025
;; Modified: May 07, 2025
;; Package-Version: 20250625.1435
;; Package-Revision: 7179ff3384ef
;; Keywords: tools, grep, icons
;; Homepage: https://github.com/hron/nerd-icons-grep
;; Package-Requires: ((emacs "30.1") (nerd-icons "0.0.1"))

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Add nerd-icons to `grep-mode' buffers when `grep-use-headings' is t

;;; Code:

(require 'nerd-icons)
(require 'grep)

(defgroup nerd-icons-grep nil
  "Manage nerd-icons-grep settings."
  :prefix "nerd-icons-grep-"
  :group 'grep
  :link '(emacs-commentary-link :tag "Commentary" "nerd-icons-grep.el"))

(defvar-local nerd-icons-grep--state nil
  "Variable to keep track of the `nerd-icons-grep--heading-filter' state.")

(defun nerd-icons-grep--heading-filter ()
  "Filter function to add nerd icons to headings of output of a grep process."
  (unless nerd-icons-grep--state
    (setq nerd-icons-grep--state (cons (point-min-marker) nil)))
  (save-excursion
    (let ((limit (car nerd-icons-grep--state))
          prop)
      ;; Move point to the old limit and update limit marker.
      (move-marker limit (prog1 (pos-bol) (goto-char limit)))
      (while (setq prop (text-property-search-forward 'font-lock-face 'grep-heading t))
        (let* ((start (prop-match-beginning prop))
               (end (prop-match-end prop))
               (heading (string-trim (buffer-substring-no-properties start end))))
          (save-excursion
            (goto-char start)
            (remove-text-properties (pos-bol) (pos-eol) '(outline-level))
            (insert-before-markers (nerd-icons-icon-for-file heading) " ")
            (add-text-properties (pos-bol) (pos-eol) '(outline-level 1)))
          (setf (cdr nerd-icons-grep--state) (prop-match-end prop)))))))

;;;###autoload
(define-minor-mode nerd-icons-grep-mode
  "Adds nerd-icons to `grep-mode' buffers when `grep-use-headings' is t."
  :global t
  (if nerd-icons-grep-mode
      (advice-add 'grep--heading-filter :after #'nerd-icons-grep--heading-filter)
    (advice-remove 'grep--heading-filter #'nerd-icons-grep--heading-filter)))

(provide 'nerd-icons-grep)
;;; nerd-icons-grep.el ends here

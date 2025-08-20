;;; nerd-icons-xref.el --- Add nerd-icons to xref buffers -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: May 11, 2025
;; Package-Version: 20250625.1113
;; Package-Revision: 477369eac359
;; Keywords: tools, xref, icons
;; Homepage: https://github.com/hron/nerd-icons-xref
;; Package-Requires: ((emacs "30.1") (nerd-icons "0.0.1") (xref "1.0.4"))

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

;; Add nerd-icons to `xref` buffers to enhance the visual representation with file type icons.

;;; Code:

(require 'nerd-icons)
(require 'xref)

(defgroup nerd-icons-xref nil
  "Manage settings for `nerd-icons-xref-mode'."
  :prefix "nerd-icons-xref-"
  :group 'xref
  :link '(emacs-commentary-link :tag "Commentary" "nerd-icons-xref.el"))

(defun nerd-icons-xref--add-icons ()
  "Add nerd-icons to xref results."
  (save-excursion
    (goto-char (point-min))
    (let ((prop))
      (while (setq prop (text-property-search-forward 'xref-group))
        (let* ((start (prop-match-beginning prop))
               (end (prop-match-end prop))
               (file (string-chop-newline (buffer-substring-no-properties start end))))
          (save-excursion
            (goto-char start)
            (insert-before-markers (nerd-icons-icon-for-file file) " ")))))))

;;;###autoload
(define-minor-mode nerd-icons-xref-mode
  "Adds nerd-icons to `xref` buffers."
  :global t
  (if nerd-icons-xref-mode
      (add-hook 'xref-after-update-hook #'nerd-icons-xref--add-icons)
    (remove-hook 'xref-after-update-hook #'nerd-icons-xref--add-icons)))

(provide 'nerd-icons-xref)
;;; nerd-icons-xref.el ends here

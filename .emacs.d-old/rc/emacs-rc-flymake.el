;;; emacs-rc-flymake.el --- flymake customization.

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

(setq flymake-gui-warnings-enabled nil)

;; http://nschum.de/src/emacs/fringe-helper/
(eval-after-load "flymake"
  '(progn
     (require 'fringe-helper)

     (defvar flymake-fringe-overlays nil)
     (make-variable-buffer-local 'flymake-fringe-overlays)

     (defadvice flymake-make-overlay (after add-to-fringe first
                                            (beg end tooltip-text face mouse-face)
                                            activate compile)
       (push (fringe-helper-insert-region
              beg end
              (fringe-lib-load (if (eq face 'flymake-errline)
                                   fringe-lib-exclamation-mark
                                 fringe-lib-question-mark))
              'left-fringe 'font-lock-warning-face)
             flymake-fringe-overlays))

     (defadvice flymake-delete-own-overlays (after remove-from-fringe activate
                                                   compile)
       (mapc 'fringe-helper-remove flymake-fringe-overlays)
       (setq flymake-fringe-overlays nil))))

(provide 'emacs-rc-flymake)
;;; emacs-rc-flymake.el ends here

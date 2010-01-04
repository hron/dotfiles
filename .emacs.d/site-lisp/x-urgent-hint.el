;;; x-urgent-hint.el --- 

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

(defun x-wm-hints (frame &optional source) 
  (mapcar '(lambda (field)  
             (if (consp field) 
                 (+ (lsh (car field) 16) (cdr field)) 
               field)) 
          (x-window-property  
           "WM_HINTS" frame "WM_HINTS"  
           (if source 
               source 
             (string-to-number (frame-parameter frame 'outer-window-id))) 
           nil t)))

(defun x-urgent-hint (frame arg) 
  (let* ((wm-hints (x-wm-hints frame)) 
         (flags (car wm-hints))) 
    (setcar wm-hints (if arg 
                         (logior flags #x00000100) 
                       (logand flags #xFFFFFEFF))) 
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

(provide 'x-urgent-hint)
;;; x-urgent-hint.el ends here

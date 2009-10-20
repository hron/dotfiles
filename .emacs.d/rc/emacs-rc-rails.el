;;;emacs-rc-rails.el --- Rails customization

;; Copyright (C) 2007, 2008  Aleksei Gusev <aleksei.gusev@gmail.com>

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: 11 Окт 2007
;; Version: $Id$
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; Code:

(setq load-path (cons "~/.emacs.d/site-lisp/emacs-rails" load-path))
(require 'rails)

;; fixing bug 
(defun run-ruby-in-buffer (cmd buf)
  "Run CMD as a ruby process in BUF if BUF does not exist."
  (let ((abuf (concat "*" buf "*")))
    (when (not (comint-check-proc abuf))
      (set-buffer (make-comint buf rails-ruby-command nil cmd))
    (inferior-ruby-mode)
    (make-local-variable 'inferior-ruby-first-prompt-pattern)
    (make-local-variable 'inferior-ruby-prompt-pattern)
    (setq inferior-ruby-first-prompt-pattern "^>> "
          inferior-ruby-prompt-pattern "^>> "))
    (pop-to-buffer abuf)))

;; fixing M-/
(defun abbrev-expansion-point-p ()
  "returns true if point is a place that might be expanded"
  (if (memq (get-text-property (- (point) 1) 'face)
            '(font-lock-string-face font-lock-comment-face font-lock-doc-face))
      nil ;; we never expand inside of string literals or comments
    (string-not-empty (syntax-word-before-point))))

(rails-find:gen "unit-tests"       "test/unit")
(rails-find:gen "fixtures"         "test/fixtures")
(rails-find:gen "functional-tests" "test/functional")
(define-keys rails-minor-mode-map
    ((rails-key "\C-c f u") 'rails-find:unit-tests)
    ((rails-key "\C-c f f") 'rails-find:functional-tests)
    ((rails-key "\C-c f x") 'rails-find:fixtures))

(setq rails-tags-dirs '("app" "lib" "test" "db" "vendor"))
;;; emacs-rc-rails.el ends here

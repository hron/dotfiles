;;; emacs-rc-ruby.el --- Ruby-mode customization.

;; Copyright (C) 2007, 2008  Warecorp

;; Author: Aleksei Gusev <aleksei.gusev@warecorp.com>
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
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;

;;; Code:

;;; ruby-mode site-lisp configuration

(add-auto-mode 'ruby-mode
               "\\.rb$" "\.rake$" "\.rxml$" "\.rjs"
               ".irbrc" "\.builder" "\.gemspec"
               "Rakefile$" "Capfile" "Gemfile" "Sitefile" "Berksfile"
               "Guardfile"
               "Vendorfile"
               "config.ru"
               "Vagrantfile" "\\.autotest$"
               "\\.prawn"
               "\\.watchr"
               "\\.rep")

(add-hook 'ruby-mode-hook
          '(lambda ()
             (auto-fill-mode 1)
             (flyspell-prog-mode)
             (setq fill-column 100)
             (setq indent-tabs-mode nil)
             ;; (turn-on-orgstruct)
             ;; (turn-on-orgtbl)
             (highlight-parentheses-mode 1)))

(setq ruby-deep-indent-paren '(?\( t))
;; (setq ruby-deep-indent-paren '())

;; Inferion ruby
(require 'inf-ruby)
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

(setq inf-ruby-first-prompt-pattern "^>> "
      inf-ruby-prompt-pattern "^>> ")

;; yari
(global-set-key [f1] 'yari-helm)

;;----------------------------------------------------------------------------
;; Ruby - flymake
;;----------------------------------------------------------------------------
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook '(lambda ()
                             (unless (tramp-tramp-file-p (buffer-file-name))
                               (condition-case err
                                   (flymake-ruby-load)
                                 (error (unless (string= "Invalid file-name" (cadr err))
                                          (error err)))))))

;;----------------------------------------------------------------------------
;; Ruby - haml & sass & scss
;;----------------------------------------------------------------------------
(add-auto-mode 'haml-mode "\.haml$")
(add-auto-mode 'sass-mode "\.sass$")
(autoload 'haml-mode "haml-mode" "Mode for editing haml files" t)
(autoload 'sass-mode "sass-mode" "Mode for editing sass files" t)

(add-hook 'haml-mode-hook '(lambda ()
                             (make-variable-buffer-local 'electric-indent-chars)
                             (setq electric-indent-chars '())
                             (setq indent-tabs-mode nil)
                             (auto-fill-mode -1)))

(require 'scss-mode)
(setq scss-compile-at-save nil)

(require 'feature-mode)

(defun guard (dir)
  "*Run guard in DIR."
  (interactive "DDirectory with Guardfile: ")
  (when (file-exists-p (concat dir "Guardfile"))
    (let* ((buffer-name (concat "*guard*<" dir ">"))
           (command "resetrails; bundle exec guard"))
      (gusev-shell-run dir command buffer-name))))

(defun gusev-shell-run (dir command buffer-name)
  (let* ((buffer (shell buffer-name)))
    (with-current-buffer buffer
      (shell-cd dir)
      (comint-send-string buffer (concat "cd " dir "; " command "\n")))))

(require 'desktop)
(add-hook 'desktop-after-read-hook
          '(lambda ()
             (guard desktop-dirname)))

;; rvm stuff
(add-auto-mode 'compilation-mode
               "\.rvm/log/.*/\\(autoconf\\|configure\\|make\\).*\.log")

;; I don't use 'run test' feature of ruby-test-mode. However I need these keys
;; for my own bindings. ;)
(add-hook 'ruby-mode-hook
          '(lambda ()
             ;; (ruby-test-mode 't)
             (local-set-key (kbd "C-c r") 'revert-buffer)))

;; Rspec examples for imenu
(defvar rspec-imenu-generic-expression
  '(("Examples"  "^\\( *\\(it\\|describe\\|context\\) +.+\\)" 1))
  "The imenu regex to parse an outline of the rspec file")

(defun rspec-set-imenu-generic-expression ()
  (when (ruby-test-spec-p (buffer-file-name))
    (make-local-variable 'imenu-generic-expression)
    (make-local-variable 'imenu-create-index-function)
    (setq imenu-create-index-function 'imenu-default-create-index-function)
    (setq imenu-generic-expression rspec-imenu-generic-expression)))

(add-hook 'ruby-test-mode-hook 'rspec-set-imenu-generic-expression)


(require 'autoinsert)
(add-to-list 'auto-insert-alist
             '(("_spec\\.rb$" . "RSpec header")
               nil
               "require 'spec_helper'

describe " (let* ((file-name (file-name-nondirectory buffer-file-name))
                  (class-name-parts (butlast (split-string file-name "_"))))
             (mapconcat 'capitalize class-name-parts "")) " do

end"
             ))

;; TODO: What is that for?
(require 'haml-mode)
(setq haml-mode-syntax-table
      (let ((table (make-syntax-table)))
	(modify-syntax-entry ?: "." table)
	table))

(require 'rhtml-mode)

(add-hook 'ruby-mode-hook 'robe-mode)

;;;###autoload
(defun helm-robe-completing-read (prompt choices &optional predicate require-match)
  (let ((collection (mapcar (lambda (c) (if (listp c) (car c) c)) choices)))
    (helm-comp-read prompt collection :test predicate :must-match
                    require-match)))

(setq robe-completing-read-func 'helm-robe-completing-read)

(provide 'emacs-rc-ruby)
;;; emacs-rc-ruby.el ends here

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
               "Rakefile$" "Capfile" "Gemfile" "Sitefile"
               "Guardfile"
               "Vendorfile"
               "config.ru"
               "Vagrantfile" "\\.autotest$"
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

;; Inferion ruby
(require 'inf-ruby)
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'ruby-mode-hook 'inf-ruby-keys)

(setq inf-ruby-first-prompt-pattern "^>> "
      inf-ruby-prompt-pattern "^>> ")

;; yari
(global-set-key [f1] 'yari-anything)

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
                             (setq indent-tabs-mode nil)))

;; (require 'flymake-haml)
;; (add-hook 'haml-mode-hook 'flymake-haml-load)
;; (add-hook 'sass-mode-hook 'flymake-sass-load)

(require 'scss-mode)
(setq scss-compile-at-save nil)

;; (require 'rdebug)
;; (add-hook 'comint-mode-hook 'turn-on-rdebug-track-mode)

;; Add binding to insert ruby debugger with F7.
(defun GAU-insert-ruby-debug ()
  (interactive)
  (let ((ruby-debug-string "require 'ruby-debug'; debugger; stop_here = 1;\n"))
    (insert ruby-debug-string))
  (previous-line)
  (ruby-indent-line))

(defun GAU-bind-insert-ruby-debug-key ()
  (local-set-key [f7] 'GAU-insert-ruby-debug))

(add-hook 'ruby-mode-hook 'GAU-bind-insert-ruby-debug-key)

(require 'feature-mode)

(defun guard (dir)
  "*Run guard in DIR."
  (interactive "DDirectory with Guardfile: ")
  (when (file-exists-p (concat dir "Guardfile"))
    (let* ((buffer-name (concat "*guard*<" dir ">"))
           (command "bundle exec guard"))
      (gusev-shell-run dir command buffer-name))))

(defun watchr (script)
  "*Run watchr in autotest mode for SCRIPT."
  (interactive "fWatchr script: ")
  (let* ((dir (file-name-directory script))
         (watchr-filename (file-name-nondirectory script))
         (buffer-name (concat "*watchr*<" watchr-filename ">"))
         (command (concat "bundle exec watchr " script)))
    (gusev-shell-run dir command buffer-name)))

(defun roetags (dir)
  "*Run 'roetags build && roetags watch' DIR."
  (interactive "DDirectory to run roetags in: ")
  (gusev-shell-run dir "roetags build && roetags watch" "*roetags*"))

(defun gusev-shell-run (dir command buffer-name)
  (let* ((buffer (shell buffer-name)))
    (with-current-buffer buffer
      (shell-cd dir)
      (comint-send-string buffer (concat "cd " dir "; "
                                         command
                                         "\n")))))

(defun watchr-all (dir)
  "*Run all watchr files in DIR."
  (interactive "DDirectory with scripts: ")
  (let ((watchr-files (directory-files dir t "\.watchr$")))
    (mapcar 'watchr watchr-files)))

(require 'desktop)
(add-hook 'desktop-after-read-hook
          '(lambda ()
             (guard desktop-dirname)))

(add-hook 'desktop-after-read-hook
          '(lambda ()
             (watchr-all desktop-dirname)))

;; rvm stuff
(add-auto-mode 'compilation-mode
               "\.rvm/log/.*/\\(autoconf\\|configure\\|make\\).*\.log")

(require 'ruby-test-mode)
;; I don't use 'run test' feature of ruby-test-mode. However I need these keys
;; for my own bindings. ;)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (ruby-test-mode 't)
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

;; (require 'hideshow)
;; (add-to-list 'hs-special-modes-alist
;;              '(ruby-mode
;;                "\\(^[[:space:]]*def[[:space:]]\\|[[:space:]]+do\\([[:space:]]+|\\|[[:space:]]*$\\)\\)"
;;                "end"
;;                "#"
;;                (lambda (arg) (ruby-end-of-block)) nil))

;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              ;; This is a workaround for MuMaMo mode (.html.erb files)
;;              (when (stringp (buffer-file-name))
;;                (hs-minor-mode 1)
;;                (cond ((string-match "_spec\.rb\\|\.rake$" (buffer-file-name))
;;                       (hs-gau-hide-level-deeply 2))
;;                      ((string-match "Gemfile$" (buffer-file-name))
;;                       (hs-show-all))
;;                      ((string-match "\.erb$" (buffer-file-name))
;;                       (message "Skipping hiding blocks..."))
;;                      (t
;;                       (hs-gau-hide-level-deeply 1))))))

;; TODO: What is that for?
(require 'haml-mode)
(setq haml-mode-syntax-table
      (let ((table (make-syntax-table)))
	(modify-syntax-entry ?: "." table)
	table))


(require 'rinari)
(add-to-list 'rinari-major-modes 'magit-mode-hook)

(defun rinari-web-server (&optional edit-cmd-args)
  "Starts a Rails webserver.  Dumps output to a compilation buffer
allowing jumping between errors and source code.  With optional prefix
argument allows editing of the server command arguments."
  (interactive "P")
  (let* ((default-directory (rinari-root))
         (script (rinari-script-path))
         (command
          (expand-file-name
           (if (file-exists-p (expand-file-name "server" script))
               "server"
             "rails server")
           script)))

    ;; Start web server in correct environment.
    ;; NOTE: Rails 3 has a bug and does not start in any environment but development for now.
    (if rinari-rails-env
        (setq command (concat command " -e " rinari-rails-env)))

    ;; For customization of the web server command with prefix arg.
    (setq command (if edit-cmd-args
                      (read-string "Run Ruby: " (concat command " "))
                    command))

    (gusev-shell-run default-directory command "*server*"))
  (rinari-launch))



(provide 'emacs-rc-ruby)
;;; emacs-rc-ruby.el ends here

(eval-after-load 'projectile
  '(progn
     (defun projectile-run-compilation (cmd)
       "Run external or Elisp compilation command CMD."
       (if (functionp cmd)
           (funcall cmd)
         (compile cmd t)))

     (defun projectile--minitest-extract-current-test-name-str ()
       (save-excursion
         (save-restriction
           (widen)
           (end-of-line)
           (or (re-search-backward "\\(test\\|def test\\|it\\) ['\"]\\(.+\\)['\"]" nil t)
               ))))

     (defun projectile-rails-minitest-test-at-point-cmd ()
       (interactive)
       (let ((command "bin/rails test")
             command-to-execute)
         (when (buffer-file-name)
           (setq command (concat command " " (file-relative-name
                                              (buffer-file-name)
                                              (projectile-project-root)))))
         (when (projectile--minitest-extract-current-test-name-str)
           (setq command
                 (concat command
                         " --name=\"/"
                         (format "%s" (replace-regexp-in-string "[#:]" "." (match-string 2)))
                         "/\"")))
         (setq command-to-execute
               (if compilation-read-command
                   (projectile-read-command "Test command: " command)
                 (car compile-history)))
         (compile command-to-execute t)))

     (define-key projectile-mode-map (kbd "C-c t") 'projectile-toggle-between-implementation-and-test)
     (define-key projectile-mode-map (kbd "C-S-t") 'projectile-toggle-between-implementation-and-test)
     (define-key projectile-mode-map (kbd "C-n") 'projectile-find-file)
     (define-key projectile-mode-map (kbd "C-S-n") 'projectile-find-file-dwim)
     (define-key projectile-mode-map (kbd "M-r") 'projectile-repeat-last-command)))

(with-eval-after-load 'dired
  (setq dired-listing-switches "-ahl --group-directories-first")
  (add-hook 'dired-mode-hook (lambda () (dired-omit-mode))))

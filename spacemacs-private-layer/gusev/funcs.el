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

(defun gusev/org-todo-convert-to-project ()
  (interactive)
  (save-excursion
    (org-todo "")
    (goto-char (point-at-bol))
    (if (looking-at "\\(**+\\) ")
        (replace-match "\\1 [%] ")))
  ;; (org-show-entry)
  ;; (org-forward-sentence)
  ;; (newline)
  ;; (goto-char (point-at-bol))
  ;; (call-interactively 'org-insert-todo-subheading)
  ;; (call-interactively 'org-do-demote)
  (goto-char (point-at-eol)))

(defun gusev/org-gtd ()
  "Prepare emacs frame to use as a GTD system."
  (interactive)
  (dolist (f org-agenda-files)
    (find-file (concat org-directory "/" f)))
  (switch-to-buffer "tasks.org")
  (let ((tasks-icon "/usr/share/icons/Yaru/256x256/apps/org.gnome.Todo.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks")))

(defun gusev/org-capture-system-wide ()
  "System-wide variant of org-capture."
  (interactive)
  (org-capture :keys "i")
  (delete-other-windows))

(defun gusev/org-gtd-capture ()
  (interactive)
  (let ((tasks-icon "/usr/share/icons/Yaru/256x256/apps/org.gnome.Todo.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks"))
  (gusev/org-capture-system-wide))

(defun gusev/org-copy-trees-from-mobileorg-to-inbox ()
  "Copies all content of ~/org/from-mobile.org into * Inbox tree
of ~/org/tasks.org"
  (save-excursion
    (find-file "~/org/from-mobile.org")
    (goto-char (point-min))
    (if (search-forward-regexp "^* " nil t)
        (let ((from-mobile-tasks))
          (mark-whole-buffer)
          (setq from-mobile-tasks
                (filter-buffer-substring (region-beginning) (region-end) t))
          (find-file "~/org/tasks.org")
          (goto-char (point-min))
          (search-forward "* Tickler")
          (beginning-of-line)
          (insert (replace-regexp-in-string
                   "^* "
                   "** "
                   from-mobile-tasks))
          (find-file "~/org/from-mobile.org")
          (save-buffer))
      ))
  (find-file "~/org/tasks.org"))

(defun gusev/org-feed-update-all-and-mobile-pull ()
  "org-feed-update-all, then org-mobile-pull"
  (interactive)
  ;; (org-feed-update-all)
  ;; (org-mobile-pull)
  (gusev/org-copy-trees-from-mobileorg-to-inbox))

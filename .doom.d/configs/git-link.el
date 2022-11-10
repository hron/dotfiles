;;; ../src/dotfiles/.doom.d/configs/git-link.el -*- lexical-binding: t; -*-

(defun git-link-bitbucket-fsecure (_hostname dirname filename branch commit start end)
  (let* ((remote-info (git-link--parse-remote (git-link--remote-url "origin")))
         (hostname (car remote-info))
         (project-with-repo (cadr remote-info))
         (project (car (split-string project-with-repo "/")))
         (repo (cadr (split-string project-with-repo "/"))))
    (format "https://%s/projects/%s/repos/%s/browse/%s%s"
            hostname
            project
            repo
            filename
            (concat (when branch (format "?at=refs/heads/%s" branch))
                    (when start
                      (if end
                          (format "#%s-%s" start end)
                        (format "#%s" start)))))))

(use-package! git-link
  :config
  (add-to-list 'git-link-remote-alist '("advtp-upstream\\|stash.f-secure.com" git-link-bitbucket-fsecure))
  (add-to-list 'git-link-commit-remote-alist '("advtp-upstream\\|stash.f-secure.com" git-link-commit-bitbucket-fsecure)))

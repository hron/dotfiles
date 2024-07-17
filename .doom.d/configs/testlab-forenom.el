;;; ../src/dotfiles/.doom.d/configs/testlab-forenom.el -*- lexical-binding: t; -*-

(require 'testlab)

(setq testlab-forenom-docker-phpunit
      "docker compose run -T --rm unittest phpunit -c ../phpunit.xml")

(defun testlab-forenom-test-file ()
  "Runs current file as a test"
  (interactive)
  (let ((file (file-relative-name (buffer-file-name) (doom-project-root))))
    (compile (concat testlab-forenom-docker-phpunit " /www/" file))))

(defun testlab-forenom-test-slap ()
  "Runs `slap' testsuite"
  (interactive)
  (compile (concat testlab-forenom-docker-phpunit " --testsuite slap")))

(add-to-list 'testlab-framework-defs
             '(php-forenom-slap . ((run . testlab-forenom-test-file)
                                   (run-all . testlab-forenom-test-slap)
                                   (run-last . recompile))))

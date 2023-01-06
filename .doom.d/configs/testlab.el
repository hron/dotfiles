;;; ../src/dotfiles/.doom.d/configs/testlab.el -*- lexical-binding: t; -*-

(defgroup testlab nil
  "Minor mode providing commands for running tests."
  :group 'test)

(defcustom testlab-test-framework nil
  "Test framework to use when testlab runs tests. Set to override automatic detection."
  :type 'symbol
  :group 'testlab
  :safe t)

(defvar testlab-framework-defs
  '((mocha . ((run . mocha-test-file)
              (run-at-point . mocha-test-at-point)
              (run-all . mocha-test-project)
              (debug . mocha-debug-file)
              (debug-at-point . mocha-debug-at-point)
              (debug-all . mocha-debug-project)
              (run-last . recompile)))
    (jest  . ((run . jest-test-run)
              (run-at-point . jest-test-run-at-point)
              (run-all . jest-test-run-all-tests)
              (debug . jest-test-debug)
              (debug-at-point . jest-test-debug-run-at-point)
              (run-last . jest-test-rerun-test)
              (debug-last . jest-test-debug-rerun-test)))
    (rustic  . ((run . rustic-cargo-test-run)
                (run-at-point . rustic-cargo-test-dwim)
                (run-all . rustic-cargo-test-run)
                (run-last . rustic-cargo-test-rerun)))))

(defun testlab-run ()
  "Run current test file"
  (interactive)
  (call-interactively (testlab--action 'run)))

(defun testlab-run-at-point ()
  "Run the test at point"
  (interactive)
  (call-interactively (testlab--action 'run-at-point)))

(defun testlab-debug ()
  "Debug current test file"
  (interactive)
  (call-interactively (testlab--action 'debug)))

(defun testlab-debug-at-point ()
  "Debug the test at point"
  (interactive)
  (call-interactively (testlab--action 'debug-at-point)))

(defun testlab-run-last ()
  "Rerun last test"
  (interactive)
  (call-interactively (testlab--action 'run-last)))

(defun testlab-debug-last ()
  "Debug last test"
  (interactive)
  (call-interactively (testlab--action 'debug-last)))

(defmacro testlab--default-action (action-type)
  `(lambda ()
     (interactive)
     (message (format "Action '%s' is not defined for '%s' test framework"
                      action-type
                      testlab-test-framework))))

(defun testlab--action (action-type)
  "Find function corresponding for ACTION-TYPE for current test framework

ACTION-TYPE could be 'run, 'run-at-point, 'debug, 'debug-at-point, 'run-last, 'debug-last"
  (alist-get action-type
             (testlab--current-framework-defs)
             (testlab--default-action action-type)))

(defun testlab--current-framework-defs ()
  (alist-get (testlab--current-framework) testlab-framework-defs))

(defun testlab--current-framework ()
  (if (not (eq testlab-test-framework nil))
      testlab-test-framework
    (cl-case (testlab--project-type)
      ('rust-cargo 'rustic)
      (('npm 'make) 'jest)
      (t 'mocha))))

(defun testlab--project-type ()
  (when (boundp projectile-project-type)
      (projectile-project-type)))

(defvar testlab-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-; f")   'testlab-run)
    (define-key map (kbd "C-; C-f") 'testlab-debug)
    (define-key map (kbd "C-; c")   'testlab-run-at-point)
    (define-key map (kbd "C-; C-c") 'testlab-debug-run-at-point)
    (define-key map (kbd "C-; a")   'testlab-run-all)
    (define-key map (kbd "C-; C-a") 'testlab-debug-all)
    (define-key map (kbd "C-; l")   'testlab-run-last)
    (define-key map (kbd "C-; C-l") 'testlab-debug-last)
    map)
  "The keymap used in command `testlab-mode'.")

;;;###autoload
(define-minor-mode testlab-mode
  "Provide shortcuts to run tests."
  :global t)

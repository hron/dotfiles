;;; ../src/dotfiles/.doom.d/configs/dap-mode.el -*- lexical-binding: t; -*-

;;;###autoload
(defun aleksei/dap-hydra ()
  "Run `aleksei/dap-hydra/body'."
  (interactive)
  (aleksei/dap-hydra/body))

(use-package! hydra
  :config

  (defun aleksei/dap-eval-thing-at-point-or-region ()
    "Evaluates region if it's active or the thing at point"
    (interactive)
    (if (region-active-p)
        (call-interactively 'dap-eval-region)
      (call-interactively 'dap-eval-thing-at-point)))

  (setq hydra-base-map (make-sparse-keymap))
  (defhydra aleksei/dap-hydra (:color pink :hint nil :foreign-keys run)
    "DAP Hydra is active: <f8>: next, (S-)<f7>: Step in/out, M-r: Restart, M-s: Stack, C-8: Eval, <f9>: Continue, S-<f5>: Disconnect"
    ("<f8>" dap-next)
    ("<f7>" dap-step-in)
    ("S-<f7>" dap-step-out)
    ("<f9>" dap-continue)
    ("M-s" dap-switch-stack-frame)
    ("M-r" dap-debug-restart)
    ("C-8" aleksei/dap-eval-thing-at-point-or-region)
    ("C-M-8" dap-ui-repl)
    ("<f12>" nil "quit" :color blue)
    ("S-<f5>" dap-disconnect :color red)))


(use-package! dap-mode
  :bind (:map dap-mode-map
         ("<f8>" . dap-breakpoint-toggle)
         ("C-<f8>" . dap-breakpoint-condition)
         ("<f9>" . dap-debug)
         ("C-9" . dap-debug))
  :custom
  (dap-auto-configure-features '())
  (dap-auto-show-output nil)
  (dap-output-window-max-height 10)
  (dap-output-window-max-height 20)
  :hook (dap-ui-repl-mode . (lambda () (setq-local company-backends (dap-ui-repl-company))))
  :init
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'aleksei/dap-hydra))))

(require 'textile-mode)

(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))

(add-to-list 'auto-mode-alist '("/tmp/.*redmine.*wiki" . textile-mode))

(add-hook 'textile-mode-hook
					'(lambda ()
						 (auto-fill-mode 0)
						 (visual-line-mode 1)))
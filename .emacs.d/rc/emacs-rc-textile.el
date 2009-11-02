(require 'textile-mode)

(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))

;; Turn on textile mode when I editting some wiki page in Redmine
(add-to-list 'auto-mode-alist '("/tmp/.*redmine.*wiki" . textile-mode))

(add-hook 'textile-mode-hook '(lambda ()
				(turn-off-auto-fill)
				(turn-on-visual-line-mode)
				;; (turn-on-orgstruct)
				;; (turn-on-orgtbl)
				(highlight-parentheses-mode 1)))

(provide 'emacs-rc-textile)
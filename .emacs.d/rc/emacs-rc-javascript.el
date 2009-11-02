;; js2-mode
(setq js2-strict-missing-semi-warning nil)

(add-to-list 'auto-mode-alist '("\\.js\\'" . espresso-mode))
(autoload 'espresso-mode "espresso" nil t)

(autoload 'inferior-moz-mode "chrome_content_moz" "MozRepl Inferior Mode" t)
(autoload 'moz-minor-mode "chrome_content_moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'espresso-mode-hook '(lambda ()
				 (flyspell-prog-mode)
				 (moz-minor-mode 1)
				 ;; (turn-on-orgstruct)
				 ;; (turn-on-orgtbl)
				 (highlight-parentheses-mode 1)))

(provide 'emacs-rc-javascript)
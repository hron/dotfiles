(add-to-list 'auto-mode-alist '("\\.js\\'" . espresso-mode))
(autoload 'espresso-mode "espresso" nil t)

(autoload 'inferior-moz-mode "chrome_content_moz" "MozRepl Inferior Mode" t)
(autoload 'moz-minor-mode "chrome_content_moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'espresso-mode-hook 'espresso-custom-setup)
(defun espresso-custom-setup ()
	(moz-minor-mode 1))

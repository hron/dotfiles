;; emacs-rc-decor.el --- Emacs decor

;; (setq-default line-number-mode t)            ; Line number displayed on modeline
;; (setq-default column-number-mode t)          ; Column number displayed on modeline
;; (setq frame-title-format 'buffer-file-name)  ; set file name as frame title
;; set file name as frame title
(setq frame-title-format "%b")

;; By default turn on colorization.
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t))

(blink-cursor-mode t)

;; Отключаем дебильный звонок
(setq visible-bell t)

;; Скролинг по одной строке
(setq scroll-step 1)
(set-scroll-bar-mode 'right)
(scroll-bar-mode 0)

;; Графические диалоговые окна тоже нахер.
(setq use-dialog-box nil)

;; Меню и тулбар туда же... ;)
(menu-bar-mode 0)
(tool-bar-mode 0)

;; Подсказки тоже отключим
(tooltip-mode nil)

;; Hе заворачиваем строки, длина которых превышает ширину окна
(setq-default truncate-lines t)
(add-hook 'minibuffer-setup-hook '(lambda ()
				    (set (make-local-variable 'truncate-lines) nil)))

;; When Show Paren mode is enabled, any matching parenthesis is highlighted
;; in `show-paren-style' after `show-paren-delay' seconds of Emacs idle time.
(show-paren-mode 1)

;; Color theme choosing
;; (require 'color-theme)
;; (color-theme-dark-hron)
;; (color-theme-clarity)

(provide 'emacs-rc-decor)
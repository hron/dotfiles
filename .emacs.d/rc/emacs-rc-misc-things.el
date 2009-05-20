;; Прозрачная работа с архивами
(if (fboundp 'auto-compression-mode)
    (auto-compression-mode t))

;; Включаем по умолчанию adaptive-fill mode.
;; (setq-default adaptive-fill-mode t)

;; Делать резервные копии для файлов?
;(setq make-backup-files nil)

;; Alist of filename patterns and backup directory names.
;; Each element looks like (REGEXP . DIRECTORY).  Backups of files with
;; names matching REGEXP will be made in DIRECTORY.
(setq backup-directory-alist
      '(("/etc/.*" . "~/.emacs.d/backups")))

;; Работа с буфером обмена также как и с внутренними кольцами копирования
;; и удаления.
(setq x-select-enable-clipboard t)

;; Undo и redo для конфигурации окон
(winner-mode t)

;; Перемещение между окнами по Shift + стрелки
(windmove-default-keybindings)

;; Между предложениями _один_, а не два пробела.
(setq sentence-end "[.?!][]\"')]*\\($\\|\t\\| \\)[ \t\n]*")

(setq tab-width 4)

(fset 'yes-or-no-p 'y-or-n-p)

;; По умолчанию комментарии "#"
(setq-default comment-start "#")

(mouse-avoidance-mode 'none)
;; Allows updating the copyright year and above mentioned GPL version manually
;; or when saving a file.  Do (add-hook 'write-file-hooks 'copyright-update).
;; (add-hook 'write-file-hooks 'copyright-update)

;; С помощью этой функции можно обрамлять регион в рамку с заголовком.
(defun GAU:box-region-with-title ()
  (interactive)
  (let ((title (read-from-minibuffer "Title: ")))
    (boxquote-region (region-beginning) (region-end))
    (boxquote-title title)))

;; А с помощью этой можно обрамлять некую шелловую команду.
;; Оказывается такая функция уже есть - `boxquote-shell-command'.. :)

;; (defun GAU:box-shell-command-whith-title ()
;;   (interactive)
;;   (let ((command (read-from-minibuffer "Shell command: "
;;                                         nil nil nil 'shell-command-history)))
;;     (save-restriction
;;       (save-excursion
;;      (let ((begin (point)))
;;            (shell-command command 1)
;;            (let ((end (mark t)))
;;                  (boxquote-region begin end)
;;                  (boxquote-title command))
;;            )))
;;     ))



(require 'ange-ftp)
(require 'lucid)

(icomplete-mode 1)


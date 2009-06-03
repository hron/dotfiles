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
;; (setq sentence-end "[.?!][]\"')]*\\($\\|\t\\| \\)[ \t\n]*")
(setq sentence-end-double-space nil)

(setq default-tab-width 2)

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

(icomplete-mode 1)

;;    If you set `set-mark-command-repeat-pop' to non-`nil', then
;; immediately after you type `C-u C-<SPC>', you can type `C-<SPC>'
;; instead of `C-u C-<SPC>' to cycle through the mark ring.  By
;; default, `set-mark-command-repeat-pop' is `nil'.
(setq set-mark-command-repeat-pop t)

;;    CUA mode provides enhanced rectangle support with visible
;; rectangle highlighting.  Use `C-RET' to start a rectangle, extend
;; it using the movement commands, and cut or copy it using `C-x' or
;; `C-c'.  `RET' moves the cursor to the next (clockwise) corner of
;; the rectangle, so you can easily expand it in any direction.
;; Normal text you type is inserted to the left or right of each line
;; in the rectangle (on the same side as the cursor).
(cua-mode 1)

;; The command `M-x cua-mode' sets up key bindings that are compatible
;; with the Common User Access (CUA) system used in many other
;; applications.  `C-x' means cut (kill), `C-c' copy, `C-v' paste
;; (yank), and `C-z' undo.  Standard Emacs commands like `C-x C-c'
;; still work, because `C-x' and `C-c' only take effect when the mark
;; is active (and the region is highlighted).  However, if you don't
;; want to override these bindings in Emacs at all, set
;; `cua-enable-cua-keys' to `nil'.
(setq cua-enable-cua-keys nil)

;; Highlight Changes mode is a minor mode that "highlights" the parts
;; of the buffer were changed most recently, by giving that text a
;; different face.  To enable or disable Highlight Changes mode, use
;; `M-x highlight-changes-mode'.
(global-hi-lock-mode 1)

;;    To enable this feature, set the buffer-local variable
;; `indicate-empty-lines' to a non-`nil' value.  The default value of
;; this variable is controlled by the variable
;; `default-indicate-empty-lines'; by setting that variable, you can
;; enable or disable this feature for all new buffers.  (This feature
;; currently doesn't work on text-only terminals.)
(setq default-indicate-empty-lines t)


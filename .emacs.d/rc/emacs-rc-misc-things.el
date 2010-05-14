;; Прозрачная работа с архивами
(if (fboundp 'auto-compression-mode)
    (auto-compression-mode t))

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

(fset 'yes-or-no-p 'y-or-n-p)

;; По умолчанию комментарии "#"
(setq-default comment-start "#")
(setq-default comment-empty-lines t)

(mouse-avoidance-mode 'none)

;; Non-nil if Size-Indication mode is enabled.
(size-indication-mode 1)

;; Allows updating the copyright year and above mentioned GPL version manually
;; or when saving a file.  Do (add-hook 'write-file-hooks 'copyright-update).
;; (add-hook 'write-file-hooks 'copyright-update)

(auto-insert-mode 1)

;; С помощью этой функции можно обрамлять регион в рамку с заголовком.
(defun GAU:box-region-with-title ()
  (interactive)
  (let ((title (read-from-minibuffer "Title: ")))
    (boxquote-region (region-beginning) (region-end))
    (boxquote-title title)))

(icomplete-mode 1)

;; Фишковое переключение между буферами
;; (iswitchb-mode 1)
;; (iswitchb-default-keybindings)
;; (setq iswitchb-default-method 'samewindow)
;; (add-hook 'iswitchb-minibuffer-setup-hook
;;           '(lambda () (set (make-local-variable 'max-mini-window-height) 7)))


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

(setq browse-url-generic-program "conkeror")
(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-new-window-flag 1)

(require 'uniquify)

(setq uniquify-buffer-name-style 'post-forward-angle-brackets
      uniquify-strip-common-suffix t)

(setq-default ediff-window-setup-function 'ediff-setup-windows-plain)

(setq-default fill-column 80)

(require 'smtpmail)

;; Function used to send the current buffer as mail.  The default is
;; `message-send-mail-with-sendmail', or `smtpmail-send-it' according
;; to the system.  Other valid values include
;; `message-send-mail-with-mailclient', `message-send-mail-with-mh',
;; `message-send-mail-with-qmail', `message-smtpmail-send-it' and
;; `feedmail-send-it'.
;;
;; The function `message-send-mail-with-sendmail' pipes your article
;; to the `sendmail' binary for further queuing and sending.  When
;; your local system is not configured for sending mail using
;; `sendmail', and you have access to a remote SMTP server, you can
;; set `message-send-mail-function' to `smtpmail-send-it' and make
;; sure to setup the `smtpmail' package correctly.  An example:
;;
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-default-smtp-server "YOUR SMTP HOST")
;;
;; To the thing similar to this, there is `message-smtpmail-send-it'.
;; It is useful if your ISP requires the POP-before-SMTP
;; authentication.  *Note POP before SMTP: (gnus)POP before SMTP.
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "smtp.warecorp.com")

(setq mail-user-agent 'gnus-user-agent)

;; comint-mode
(add-hook 'comint-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-mode-hook '(lambda ()
                               (local-set-key (kbd "C-c g") 'recompile)))

(setq grep-program "zgrep")

;;
;; VC
;;
(setq
 ;; Emacs normally  does not save  backup files for source  files that
 ;; are maintained  with version control.  If you want to  make backup
 ;; files even  for files that  use version control, set  the variable
 ;; `vc-make-backup-files' to a non-`nil' value.
 vc-make-backup-files t

 ;;    The variable  `vc-follow-symlinks' controls  what to do  when a
 ;; symbolic link points to a version-controlled file. If it is `nil',
 ;; VC only displays a warning message. If it is `t', VC automatically
 ;; follows the  link, and visits  the real file instead,  telling you
 ;; about this in the echo area.  If the value is `ask' (the default),
 ;; VC asks you each time whether to follow the link.
 vc-follow-symlinks t

 ;;    VC mode does much of its work by running the shell commands for
 ;; RCS,  CVS  and SCCS.  If  `vc-command-messages'  is non-`nil',  VC
 ;; displays messages  to indicate which  shell commands it  runs, and
 ;; additional messages when the commands finish.
 vc-command-messages t
 )

(setq tags-revert-without-query t)

;;----------------------------------------------------------------------------
;; Delete the current file
;;----------------------------------------------------------------------------
(defun delete-this-file ()
  (interactive)
  (or (buffer-file-name) (error "no file is currently being edited"))
  (when (yes-or-no-p "Really delete this file?")
    (delete-file (buffer-file-name))
    (kill-this-buffer)))

;;----------------------------------------------------------------------------
;; Desktop saving
;;----------------------------------------------------------------------------
;; save a list of open files in ~/.emacs.d/.emacs.desktop
;; save the desktop file automatically if it already exists
(require 'desktop)
(setq-default desktop-path '("." "~/.emacs.d"))
(setq desktop-save 'ask-if-new)
(desktop-save-mode 1)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
		(file-name-history        . 100)
		(ido-last-directory-list  . 100)
		(ido-work-directory-list  . 100)
		(ido-work-file-list       . 100)
		(grep-history             . 30)
		(compile-history          . 30)
		(minibuffer-history       . 50)
		(query-replace-history    . 60)
		(read-expression-history  . 60)
		(regexp-history           . 60)
		(regexp-search-ring       . 20)
		(search-ring              . 20)
		(shell-command-history    . 50)
		tags-file-name
		register-alist)))

;; Default dictionary to use if `ispell-local-dictionary' is nil.
(setq ispell-dictionary "american")

;; Cleanup some blank problems in all buffer or at region.
(setq whitespace-style '(tabs
                         spaces
                         trailing
                         lines
                         space-before-tab
                         newline
                         empty
                         space-after-tab
                         space-mark
                         tab-mark
                         newline-mark))
(add-hook 'before-save-hook 'whitespace-cleanup)

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Color theme loading, must be the last.
(load-library "color-themes/color-theme-dark-hron")
(color-theme-dark-hron)

(setq split-width-threshold 120)

(provide 'emacs-rc-misc-things)

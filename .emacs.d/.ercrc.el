;;; emacs-rc-erc.el --- 

;; Copyright (C) 2004, 2008 Aleksei Gusev <aleksei.gusev@gmail.com>
;;
;; Version: $Id$
;; Status: not intended to be distributed yet

(setq erc-user-full-name "Aleksei Gusev")

(autoload 'erc-select "erc" "IRC client." t)
(require 'erc)
(setq erc-auto-query t)
(add-hook 'erc-mode-hook 'erc-add-scroll-to-bottom)
(require 'erc-match)
(erc-autojoin-mode 1)
(erc-match-mode)

(require 'erc-track)
;; (erc-track-modified-channels-mode t)

(add-hook 'erc-mode-hook
          '(lambda ()
             (require 'erc-pcomplete)
             (pcomplete-erc-setup)
             (erc-completion-mode 1)))

(require 'erc-fill)
(erc-fill-mode t)
(require 'erc-ring)
(erc-ring-mode t)
(require 'erc-netsplit)
(erc-netsplit-mode t)
(erc-timestamp-mode t)
(setq erc-timestamp-format "[%R-%m/%d]")
(erc-button-mode nil)

(setq erc-server-coding-system (quote (cp1251 . cp1251)))

;; logging:
(setq erc-log-insert-log-on-open nil)
(setq erc-log-channels t)
(setq erc-log-channels-directory "~/var/log/irclogs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps nil)

;; (defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
;;   (save-some-buffers t (lambda () 
;; 			 (when (and (eq major-mode 'erc-mode)
;; 				    (not (null buffer-file-name)))))))

(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)
(add-hook 'erc-mode-hook '(lambda () 
			    (when (not (featurep 'xemacs))
			      (set (make-variable-buffer-local
				    'coding-system-for-write)
				   'emacs-mule))))
;; end logging

;; Truncate buffers so they don't hog core.
(setq erc-max-buffer-size 20000)
(defvar erc-insert-post-hook)
(require 'erc-truncate)
;(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
;(setq erc-truncate-buffer-on-save t)

;; Nickserver identifying
(require 'erc-services)
(erc-services-mode 1)
;; Alist of NickServer details, sorted by network.
;; Every element in the list has the form
;;   \(SYMBOL NICKSERV REGEXP NICK KEYWORD USE-CURRENT ANSWER)
;; SYMBOL is a network identifier, a symbol, as used in `erc-networks-alist'.
;; NICKSERV is the description of the nickserv in the form nick!user@host.
;; REGEXP is a regular expression matching the message from nickserv.
;; NICK is nickserv's nickname.  Use nick@server where necessary/possible.
;; KEYWORD is the keyword to use in the reply message to identify yourself.
;; USE-CURRENT indicates whether the current nickname must be used when
;;   identifying.
;; ANSWER is the command to use for the answer.  The default is 'privmsg.
;;   This last element is optional.
(setq erc-nickserv-alist
      (cons erc-nickserv-alist
	    '((irc_by
	       "NickServ!NickServ@multiport."
	       "/msg\\s-NickServ\\s-IDENTIFY\\s-<password>"
	       "NickServ"
	       "IDENTIFY" nil nil))))
;;  Passwords used when identifying to NickServ automatically.
;; Example of use:
;;   (setq erc-nickserv-passwords
;;         '((freenode ((\"nick-one\" . \"password\")
;;                      (\"nick-two\" . \"password\")))
;;           (DALnet ((\"nick\" . \"password\")))))
(setq erc-nickserv-passwords
      '((irc_by (("hron" . "aleks7771")))))
;; Ask for the password when identifying to NickServ.
(setq erc-prompt-for-nickserv-password t)
      
;; Join the #emacs and #erc channels whenever connecting to Freenode.
;; (setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#erc" "#gentoo" "#conkeror" "#ruby" "#rubyonrails")
;; 				    ("irc.by" "#linux" "#1182" "#velominsk")))
(setq erc-autojoin-channels-alist '(("irc.by" "#1182")))

;; Finally, tell erc to connect to freenode.
;; (erc :server "irc.by" :port 6667
;;      :nick "hron|erc" :full-name "Aleksei Gusev")

;; emacs-rc-erc.el ends here

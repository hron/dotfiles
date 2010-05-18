;;; emacs-rc-erc.el ---

;; Copyright (C) 2004, 2008 Aleksei Gusev <aleksei.gusev@gmail.com>
;;
;; Version: $Id$
;; Status: not intended to be distributed yet

(setq erc-user-full-name "Aleksei Gusev")

(autoload 'erc-select "erc" "IRC client." t)
(require 'erc)
(setq erc-auto-query 'frame
      erc-query-display 'frame)
(add-hook 'erc-mode-hook 'erc-add-scroll-to-bottom)
(require 'erc-match)
(erc-autojoin-mode 1)
(erc-match-mode)

(require 'erc-track)
(setq erc-track-visibility 'nil
      erc-track-exclude-types  '("NICK" "JOIN" "QUIT" "PART" "333" "353")
      erc-track-exclude-server-buffer t)

;; (require 'erc-nicklist)

(add-hook 'erc-mode-hook
          '(lambda ()
             (require 'erc-pcomplete)
             (pcomplete-erc-setup)
             (erc-completion-mode 1)))

(require 'erc-fill)
(setq erc-fill-column 66)
(erc-fill-mode t)
(require 'erc-ring)
(erc-ring-mode t)
(require 'erc-netsplit)
(erc-netsplit-mode t)
(erc-timestamp-mode t)
(setq erc-timestamp-format "[%R-%m/%d]")
(erc-button-mode nil)

(setq erc-server-coding-system
      '(lambda (target)
         (let ((server (car (split-string (buffer-name (erc-server-buffer)) ":"))))
           (cond ((string= "irc.by" server)
                  (cons 'cp1251 'cp1251))
                 ((string= "bynets.org" server)
                  (cons 'cp1251 'cp1251))
                 (t
                  (cons 'utf-8 'utf-8))))))

;; logging:
(setq erc-log-insert-log-on-open nil)
(setq erc-log-channels t)
(setq erc-log-channels-directory "~/var/log/irclogs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps nil)

;; (defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
;;   (save-some-buffers t (lambda ()
;;                       (when (and (eq major-mode 'erc-mode)
;;                                  (not (null buffer-file-name)))))))

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

(setq erc-server-flood-margin 9
      erc-server-flood-penalty 4)

(require 'erc-input-fill)

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
;; (setq erc-nickserv-alist
;;       (cons erc-nickserv-alist
;;          '((IrcBy
;;             "NickServ!NickServ@multiport."
;;             "/msg\\s-NickServ\\s-IDENTIFY\\s-<password>"
;;             "NickServ"
;;             "IDENTIFY" nil nil))))
(add-to-list 'erc-nickserv-alist
             '(IrcBy
               "NickServ!NickServ@multiport."
               "/msg\\s-NickServ\\s-IDENTIFY\\s-<password>"
               "NickServ"
               "IDENTIFY" nil nil))

;; Ask for the password when identifying to NickServ.
(setq erc-prompt-for-nickserv-password nil)

;; Load authentication info from an external source.  Put sensitive
;; passwords and the like in here.
(load "~/.emacs.d/.erc-auth")

(setq erc-autojoin-channels-alist '(("irc.by" "#1182" "#emacs"
                                     "#linux" "#unix" "#velominsk")
                                    ("bynets.org" "#emacs" "#unix")))

(defun gau-erc ()
  (interactive)
  (erc :server "127.0.0.1" :nick "hron" :full-name "Aleksei Gusev")
  (erc :server "irc.by" :port 6667
       :nick "hron" :full-name "Aleksei Gusev")
  (erc :server "bynets.org"
       :nick "hron2" :full-name "Aleksei Gusev"))

(provide 'emacs-rc-erc)

;; emacs-rc-erc.el ends here

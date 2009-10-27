;; The `gnus-select-method' variable says where Gnus should look for news.
;; This variable should be a list where the first element says "how" and
;; the second element says "where".  This method is your native method.
;; All groups not fetched with this method are foreign groups.
(setq gnus-select-method '(nntp "news.gmane.org"))

(setq gnus-secondary-select-methods
      '((nnimap "wmail"
		(nnimap-address "imap.warecorp.com")
		(nnimap-stream tls))
	(nnimap "gmail"
		(nnimap-address "imap.gmail.com")
		(nnimap-stream tls))))

;; Splitting mail

;; If non-`nil', do crossposting if several split methods match the
;; mail.  If `nil', the first match in `nnimap-split-rule' found will
;; be used.
(setq nnimap-split-crosspost nil)
(setq nnimap-split-inbox '("INBOX"))
(setq nnimap-split-rule
      '(( "wmail" ( ".*"
		    (
		     ;; (("INBOX.Junk"
		     ;; 	"^X-Spam-Status: Yes")
		     ("INBOX.Robots"
		      "^\\(To:.*\\(apache\\|root\\)@warecorp.com\\|From:.*nagios@\\(warecorp.com\\|wc-snoop-00\\)\\)")
		     ("INBOX.Robots" "From:.*\\(denyhosts\\|root\\|.*-owner\\)@.*")
		     ("INBOX.jobs@warecorp.com" "^To:.*jobs@warecorp.com")
		     ("INBOX.OTRS" "^From:.*otrs@.*warecorp.com")
		     ("INBOX.Lists.Projects.\\1" "^List-Id:.*project\\.\\([^\\.]+\\)")
		     ("INBOX.Lists.Office" "^List-Id:.*office.warecorp.com")
		     ("INBOX.Lists.Minsk" "^List-Id:.*minsk.warecorp.com")
		     ("INBOX.Lists.Global" "^List-Id:.*global.warecorp.com"))))))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-posting-styles
      '((".*"
	 (signature
	  (concat "WBR, Aleksei Gusev")))
	(".*wmail.*"
	 (address user-mail-address-work)
	 (signature
	  (concat "WBR, Aleksei Gusev\n"
		  "Director of IT Services Department\n"
		  "Warecorp, http://www.warecorp.com")))))

;; A three pane layout, Group buffer on the left, summary buffer
;; top-right, article buffer bottom-right:
;; (gnus-add-configuration
;;  '(article
;;    (horizontal 1.0
;; 	       (vertical 60
;; 			 (group 1.0))
;; 	       (vertical 1.0
;; 			 (summary 0.25 point)
;; 			 (article 1.0)))))
;; (gnus-add-configuration
;;  '(summary
;;    (horizontal 1.0
;; 	       (vertical 60
;; 			 (group 1.0))
;; 	       (vertical 1.0
;; 			 (summary 1.0 point)))))

;; (setq gnus-summary-line-format "%B%U%R%z%I%(%[%4L: %-23,23f%]%) ;; %s\n")

;; (setq smtpmail-default-smtp-server "smtp.gmail.com"
;; 			smtpmail-smtp-server "smtp.gmail.com"
;; 			smtpmail-starttls-credentials '(( "smtp.gmail.com" 587 nil nil))
;; 			smtpmail-smtp-service 587
;; 			smtpmail-debug-info t)

;; (add-hook 'message-send-hook
;; 					'(lambda ()
;; 						 (save-excursion
;; 							 (beginning-of-buffer)
;; 							 (if (string-match-p
;; 										user-mail-address-work
;; 										(mail-header 'from (mail-header-extract)))
;; 									 (progn
;; 										 (set (make-local-variable 'smtpmail-smtp-server)
;; 													"smtp.warecorp.com")
;; 										 (message smtpmail-smtp-server))))))

(setq smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-debug-info t)

;; Available SMTP accounts.
(defvar smtp-accounts
  '((plain "aleksei.gusev@warecorp.com" "smtp.warecorp.com" 25  nil nil)
    (ssl "aleksei.gusev@gmail.com" "smtp.gmail.com" 587 nil nil nil nil)))

;; Default smtpmail.el configurations.
(require 'smtpmail)

(defun set-smtp-plain (server port user password)
  "Set related SMTP variables for supplied parameters."
  (setq smtpmail-smtp-server server
	smtpmail-smtp-service port)
  ;; smtpmail-auth-credentials (list (list server port user password))
  ;; smtpmail-starttls-credentials nil)
  (message "Setting SMTP server to `%s:%s'." server port))

(defun set-smtp-ssl (server port user password key cert)
  "Set related SMTP and SSL variables for supplied parameters."
  (setq starttls-use-gnutls t
	starttls-gnutls-program "gnutls-cli"
	starttls-extra-arguments nil
	smtpmail-smtp-server server
	smtpmail-smtp-service port
	smtpmail-starttls-credentials (list (list server port key cert)))
  ;; smtpmail-auth-credentials (list (list server port user password))
  ;; smtpmail-starttls-credentials (list (list server port key cert)))
  (message
   "Setting SMTP server to `%s:%s' (SSL enabled.)" server port))

(defun change-smtp ()
  "Change the SMTP server according to the current from line."
  (save-excursion
    (loop with from = (save-restriction
			(message-narrow-to-headers)
			(message-fetch-field "from"))
	  for (acc-type address . auth-spec) in smtp-accounts
	  when (string-match address from)
	  do (cond
	      ((eql acc-type 'plain)
	       (return (apply 'set-smtp-plain auth-spec)))
	      ((eql acc-type 'ssl)
	       (return (apply 'set-smtp-ssl auth-spec)))
	      (t (error "Unrecognized SMTP account type: `%s'." acc-type)))
	  finally (error "Cannot infer SMTP information."))))

(add-hook 'message-send-hook 'change-smtp)

(gnus-demon-add-rescan)
(gnus-demon-add-scanmail)
(gnus-demon-add-disconnection)

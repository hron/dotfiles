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
(setq nnimap-split-inbox '("INBOX"))
(setq nnimap-split-rule
      '(( "wmail" ( ".*"
		    (("INBOX.Junk"
		      "^X-Spam-Status: Yes")
		     ("INBOX.Robots"
		      "^\\(To:.*\\(apache\\|root\\)@warecorp.com\\|From:.*nagios@warecorp.com\\)")
		     ("INBOX.Robots" "From:.*\\(denyhosts\\|root\\)@.*")
		     ("INBOX.jobs@warecorp.com" "^To:.*jobs@warecorp.com")
		     ("INBOX.OTRS" "^From:.*otrs@.*warecorp.com")
		     ("INBOX.Lists.Projects.\\1" "^List-Id:.*project\\.\\([^\\.]+\\)")
		     ("INBOX.Lists.Office" "^List-Id:.*office.warecorp.com")
		     ("INBOX.Lists.Global" "^List-Id:.*global.warecorp.com"))))))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-posting-styles
      '((".*"
	 (signature
	  (concat "WBR, Aleksei Gusev\n"
		  "Director of IT Services Department\n"
		  "Warecorp, http://www.warecorp.com")))))

;; A three pane layout, Group buffer on the left, summary buffer
;; top-right, article buffer bottom-right:
(gnus-add-configuration
 '(article
   (horizontal 1.0
	       (vertical 60
			 (group 1.0))
	       (vertical 1.0
			 (summary 0.25 point)
			 (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
	       (vertical 60
			 (group 1.0))
	       (vertical 1.0
			 (summary 1.0 point)))))

;; (setq gnus-summary-line-format "%B%U%R%z%I%(%[%4L: %-23,23f%]%) %s\n")
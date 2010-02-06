(require 'nnir)

;; The `gnus-select-method' variable says where Gnus should look for news.
;; This variable should be a list where the first element says "how" and
;; the second element says "where".  This method is your native method.
;; All groups not fetched with this method are foreign groups.
(setq gnus-select-method '(nntp "news.gmane.org"))

(setq gnus-secondary-select-methods
      '((nnimap "gmail"
		(nnimap-address "imap.gmail.com")
		(nnimap-stream tls)
		(nnir-search-engine imap))))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-posting-styles
      '((".*"
	 (signature
	  (concat "WBR, Aleksei Gusev")))))


(setq smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-starttls-credentials '(( "smtp.gmail.com" 587 nil nil))
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

;; Default smtpmail.el configurations.
(require 'smtpmail)

(setq gnus-ignored-newsgroups "[:`'\"]\|^$")

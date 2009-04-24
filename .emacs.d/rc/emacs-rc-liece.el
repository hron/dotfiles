;; IRC Server
(setq liece-server '(:host "irc.by" :service 6669))

;; Private information of user.
(setq liece-name "Aleksei Gusev")
(setq liece-nickname "hron")
(setq liece-nickserv-password "aleks7771")

;; Customization to change Look & Feel.
;; If non-nil, channel buffer would be displayed.
(setq liece-channel-buffer-mode t)
;; If non-nil, nick buffer would be displayed.
(setq liece-nick-buffer-mode t)
;; If non-nil, channel list buffer would be displayed.
(setq liece-channel-list-buffer-mode t)

(setq liece-intl-use-localized-message t)
(setq liece-window-default-style "bottom")
(setq liece-beep-on-bells 'always)
;(setq liece-beep-words-list '("foo" "bar"))
(setq liece-display-channel-always t)
(setq liece-display-time nil)
(setq liece-display-prefix-tag t)
(setq liece-use-x-face t)
(setq liece-ctcp t)
(setq liece-insert-environment-version t)
(setq liece-beep-when-invited t)
(setq liece-beep-when-privmsg t)
(setq liece-reconnect-automagic t)
(setq liece-display-unread-mark t)

;; Highlighten IRC buffers.
(setq liece-highlight-mode t)
;; If `liece-highlight-mode' is non-nil, strings which matches 
;; following regular expression would be emphasized by colouring.
;(setq liece-highlight-pattern (regexp-opt '("foo" "bar")))

;; Channels we want to join startup time.
(setq liece-startup-channel-list
      '("#1182" "#Buktopuha"))
;; Channel bindings to its numerical expression.
;; Each element of list are bound to n-th.
;; DCC external programs.
;; When this is not specified, we search `dcc' executable in exec-path.
(setq liece-dcc t)
;; Don't receive any files automatically.
(setq liece-dcc-receive-direct nil) 

;;; XEmacs specific features
;; Normal position of toolbar icons.
(setq liece-toolbar-position 'top) 
;; Display smiley mark.
(setq liece-use-smiley t)          

;;; URL browsing.
;; Specify browser name. To see available browser names, 
;; refer docstring of `liece-url-browser-function'.
;(setq liece-url-browser-name "w3m") 

;; Automatic invisible.
(add-hook 'liece-after-001-hook
       	  (function (lambda (prefix rest)
		      (liece-send
		       "MODE %s +i" liece-real-nickname)
		      nil)))

;;; Converting codings.
;; Detect coding automatically.
;(setq liece-detect-coding-system t)
;; Convert deprecated hankaku kana to zenkaku kana.
;(setq liece-convert-hankaku-katakana t)

(setq liece-mime-charset-for-write 'cp1251)
(setq liece-mime-charset-for-read 'cp1251)

(setq liece-quoted-colors-ircle
  '("white" "cyan" "red" "orange" "yellow" "LightGreen" "DarkOliveGreen"
    "cyan4" "turquoise" "cyan" "cyan" "cyan" "cyan" "cyan" "cyan"
    "DarkBlue" "purple1" "purple2" "purple3" "magenta"))

(setq liece-quoted-colors-mirc
  '("white" "cyan" "blue" "DarkOliveGreen" "red" "brown" "purple"
    "orange" "yellow" "green" "cyan4" "turquoise" "RoyalBlue" "HotPink"
    "gray50" "gray75" "cyan" "cyan" "cyan" "cyan"))

(defun liece-open-server (host &optional service)
  "Open chat server on HOST.
If HOST is nil, use value of environment variable \"IRCSERVER\".
If optional argument SERVICE is non-nil, open by the service name."
  (liece-server-keyword-bind host
    (when prescript
      (if (fboundp prescript)
	  (funcall prescript)
	(call-process shell-file-name nil nil nil
		      shell-command-switch prescript))
      (when prescript-delay
	(sleep-for prescript-delay)))
    (if password
	(setq liece-ask-for-password nil
	      liece-password password))
    (if (and (memq type '(rlogin telnet)) relay)
	(setq liece-tcp-relay-host relay))
    (setq liece-server-process (liece-open-server-internal host service type))
    (liece-command-ping)
    (if (null (liece-wait-for-response "^:[^ ]+ [4P][5O][1N][ G]"))
	(progn
	  ;; We have to close connection here, since the function
	  ;;  `liece-server-opened' may return incorrect status.
	  (liece-close-server-internal)
	  (error (_ "Connection to %s timed out") host))
      (set-process-sentinel liece-server-process 'liece-sentinel)
      (set-process-filter liece-server-process 'liece-filter)
      (if (or liece-ask-for-password liece-reconnect-with-password)
	  (let ((password
		 (liece-read-passwd (_ "Server Password: "))))
	    (or (string= password "")
		(setq liece-password password))))
      (if liece-password
	  (liece-send "PASS %s" liece-password))
      (setq liece-reconnect-with-password nil)
      (liece-send "USER %s * * :%s"
		  (or (user-real-login-name) "Nobody")
		  (if (and liece-name (not (string= liece-name "")))
		      liece-name
		    "No Name"))
      (liece-send "NICK %s" liece-nickname)
      (setq liece-last-nickname liece-real-nickname
	    liece-nick-accepted 'sent)
      (if liece-nickserv-password
	  (liece-send "PRIVMSG NickServ IDENTIFY %s" liece-nickserv-password)))))

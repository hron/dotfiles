;;; -*- mode: emacs-lisp, encoding: koi8-r -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Всякие разные настройки
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq
;;  gnus-startup-file "~/.newsrc"
 ;; По дефолту юзаем свой nntp сервак
;;  gnus-select-method '(nntp "ddt.demos.su")
 ;; Асинхронность нафиг
 gnus-asynchronous nil
 ;;  Смайлики нафиг
 gnus-treat-display-smileys nil
 ;;  Треды изначально показывать свернутыми
 gnus-thread-hide-subtree t
 ;; I'm cool :)
 gnus-novice-user nil
 ;; Hе перескакивать автоматом на следующую ньюсгруппу
;;  gnus-auto-select-next nil
 ;; Автоматически подписываемся на новые группы и переносим их в самый верх
 gnus-subscribe-newsgroup-method 'gnus-subscribe-randomly
 ;; Всегда читать news-dribble
 gnus-always-read-dribble-file t
 ;; Проигрывать какую-то фигню при старте. Какую именно ещё не знаю... :)
;;  gnus-play-startup-jingle t
 ;; Не задавать вопроса о количестве читаемых сообщений.
 gnus-large-newsgroup nil
 ;; Строка рисуемая в summary buffer.
 gnus-summary-line-format "%U%R%z%B%(%[%4L: %-23,23f%]%) %s\n"
 ;; Разъюючиваем сюда
 gnus-uu-default-dir "~/News/save/"
 ;; Переключение кодировок (C-u NUMBER g).
 gnus-summary-show-article-charset-alist
 '((1 . koi8-r)
   (2 . cp1251)
   (3 . cp866)
   (4 . utf-8)
   (5 . latin-1))
 ;; Показывать дату в приемлемом формате
 gnus-treat-date-user-defined 'head
 ;; Делать буквы в начале предложения заглавными.
 gnus-treat-capitalize-sentences nil
 ;; Не показывать сообщения со скорингом ниже чем
 gnus-thread-expunge-below 0
 ;; Что из заголовков показывать
 gnus-visible-headers '("^Date:"
                        "From:"
                        "^To:"
                        "^X-Comment-To:"
                        "^Subject:"
                        "^X-FTN-Tearline:"
                        "^Organization:")
 gnus-article-mode-line-format "Gnus: [%w] %S%m"
 ;; Сортировка заголовков
 gnus-sorted-header-list '("^Subject:"
                           "^Date:"
                           "^From:"
                           "^X-Comment-To:"
                           "^To:"
                           "^X-FTN-Tearline:"
                           "^Organization:")
 ;; modeline size
 gnus-mode-non-string-length (+ 30
                                (if line-number-mode 5 0)
                                (if column-number-mode 5 0))
 ;; List of functions taking a string argument that simplify subjects.
 ;; The functions are applied recursively.
 ;; Useful functions to put in this list include:
 ;; `gnus-simplify-subject-re', `gnus-simplify-subject-fuzzy',
 ;; `gnus-simplify-whitespace', and `gnus-simplify-all-whitespace'.
 gnus-simplify-functions '(gnus-simplify-subject-re
                           gnus-simplify-whitespace
                           gnus-simplify-all-whitespace)
 ;; The `message-use-followup-to' variable says what to do about
 ;; `Followup-To' headers.  If it is `use', always use the value.  If it is
 ;; `ask' (which is the default), ask whether to use the value.  If it is
 ;; `t', use the value unless it is `poster'.  If it is `nil', don't use
 ;; the value.
 message-use-followup-to 'use
 ;; Variable to control whether use the locally stored NOV and
 ;; articles when plugged, e.g. essentially using the Agent as a cache.
 ;; The default is non-`nil', which means to use the Agent as a cache.
 gnus-agent-cache t
 ;; This selects the function used to render HTML.  The predefined
 ;; renderers are selected by the symbols `w3', `w3m'(1), `links',
 ;; `lynx', `w3m-standalone' or `html2text'.  If `nil' use an external
 ;; viewer.  You can also specify a function, which will be called
 ;; with a MIME handle as the argument.
 mm-text-html-renderer 'w3m
 ;; *Regexp matching normal Supercite attribution lines.
 ;; The first grouping must match prefixes added by other packages.
 message-cite-prefix-regexp   (if (string-match "[[:digit:]]" "1") ;; support POSIX?
                                  "\\([ \t]*[-_.[:word:]]+>+\\|[ \t]*>\\)+"
                                ;; ?-, ?_ or ?. MUST NOT be in syntax entry w.
                                (let ((old-table (syntax-table))
                                      non-word-constituents)
                                  (set-syntax-table text-mode-syntax-table)
                                  (setq non-word-constituents
                                        (concat
                                         (if (string-match "\\w" "-")  "" "-")
                                         (if (string-match "\\w" "_")  "" "_")
                                         (if (string-match "\\w" ".")  "" ".")))
                                  (set-syntax-table old-table)
                                  (if (equal non-word-constituents "")
                                      "\\([ \t]*\\(\\w\\)+>+\\|[ \t]*>\\)+"
                                    (concat "\\([ \t]*\\(\\w\\|["
                                            non-word-constituents
                                            "]\\)+>+\\|[ \t]*>\\)+"))))
 gnus-extra-headers '(To Newsgroups X-Comment-To)
 gnus-show-threads t
 gnus-use-scoring t
 ;; Sorting options
 gnus-thread-sort-functions 'gnus-thread-sort-by-date
 gnus-article-sort-functions 'gnus-article-sort-by-date
 )

;; Daemonic Gnus behavior
(require 'gnus-demon)
(gnus-demon-add-handler '(lambda ()
			   (gnus-group-get-new-news)) 15 t)
(gnus-demon-init)			; this is redundant in No Gnus

;; (setq gnus-awesome-client-process (start-process "awesome-client"
;; 						 "*awesome-client*"
;; 						 "awesome-client"))

;; (add-hook 'gnus-group-update-hook
;; 	  '(lambda ()
;; 	     (let ((wmail (number-to-string
;; 			   (gnus-range-length (gnus-sequence-of-unread-articles
;; 					 "nnimap+wc:INBOX"))))
;; 		   (gmail (number-to-string
;; 			   (gnus-range-length (gnus-sequence-of-unread-articles
;; 					 "nnimap+gmail.com:INBOX")))))
;; 	       (process-send-string gnus-awesome-client-process
;; 				    (concat "mailboxes[\"Wmail\"] = \"" wmail "\"\n"))
;; 	       (process-send-string gnus-awesome-client-process
;; 				    (concat "mailboxes[\"Gmail\"] = \"" gmail "\"\n")))
;; 	     (gnus-group-highlight-line))
;; 	  t)
  
;; (add-hook 'gnus-exit-gnus-hook
;; 	  '(lambda ()
;; 	     (delete-process gnus-awesome-client-process)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Раскрасим gnus по-своему =)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'w3m)
(setq w3m-goto-article-function 'browse-url)


(require 'gnus-art)
(set-face-foreground 'gnus-header-from-face "white")
;(make-face-bold 'gnus-emphasis-bold)
;(make-face-italic 'gnus-emphasis-italic)

;; (require 'gnus-cite)
;; (set-face-foreground 'gnus-cite-face-1 "blue3")
;; (set-face-foreground 'gnus-cite-face-2 "blue3")
;; (set-face-foreground 'gnus-cite-face-3 "blue3")
;; (set-face-foreground 'gnus-cite-face-4 "blue3")
;; (set-face-foreground 'gnus-cite-face-5 "blue3")
;; (set-face-foreground 'gnus-cite-face-6 "blue3")
;; (set-face-foreground 'gnus-cite-face-7 "blue3")
;; (set-face-foreground 'gnus-cite-face-8 "blue3")
;; (set-face-foreground 'gnus-cite-face-9 "blue3")
;; (set-face-foreground 'gnus-cite-face-10 "blue3")
;; (set-face-foreground 'gnus-cite-face-11 "blue3")

(require 'message)
(set-face-foreground 'message-cited-text-face "DarkCyan")
(set-face-foreground 'message-separator "DarkCyan")
(set-face-foreground 'message-header-other "VioletRed1")

(make-face 'score-to-me)
(set-face-foreground 'score-to-me "White")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Hастраиваем кодировку
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq message-default-charset 'koi8-r)
(setq rfc2047-header-encoding-alist
      '(("Newsgroups"  . nil)
        ("Message-ID"  . nil)
        (t             . mime)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Подпись, дополнительные заголовки...
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq message-signature nil)

(setq gnus-posting-styles
      '(
;; *

        (".*"
         (name "Aleksei Gusev")
         (address user-mail-address)
         (organization "//Linux or dead...")

         (eval (setq SNP:quote-initials nil     ; по умолчанию не цитируем с инициалами
                     SNP:add-x-comment-to nil)) ; и не добавляем X-Comment-To

         (eval (setq mail-citation-hook
                     '(lambda ()
                        (SNP:citation)
                        (goto-char (point-min))
                        (search-forward "\n\n")
                        (SNP:citation-line))
                     gnus-message-setup-hook nil))

         ;; создаём фиктивное мыло, чтобы спам не прорвался.
         (eval (setq user-antispam-mail-address (split-string user-mail-address "@")
                     user-antispam-mail-address (concat (nth 0 user-antispam-mail-address)
                                                        " at "
                                                        (nth 1 user-antispam-mail-address))))

;;          (signature (concat "WBR, " user-full-name "  UIN:" user-uin-number "  JID:" user-jabber-address)))
         (signature (concat "With Best Regards,\n"
			    "Aleksei Gusev\n"
			    "Director of IT Services Department\n"
			    "Warecorp\n"
			    "http://www.warecorp.com")))

        ;; используем рабочий e-mail
        (".*warecorp.*"
         (address "alexei.gusev@warecorp.com")
         (organization "Warecorp LLC"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Почта
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; A list of secondary methods that will be used for reading news.
;; This is a list where each element is a complete select method (see
;; `gnus-select-method').
(setq gnus-select-method '(nntp "ddt.demos.su"))
(setq gnus-secondary-select-methods '((nnimap "wc"
					      (nnimap-address "mail.warecorp.com")
					      (nnimap-stream starttls))
				      (nnimap "gmail.com"
					      (nnimap-address "imap.gmail.com")
					      (nnimap-stream ssl))))
(setq nnimap-split-inbox "INBOX")
(setq nnimap-split-rule
      '((".*" (".*" (("INBOX.galaxy/robots" "Subject:.*{dgnovice190} Turn .*\\(report\\|order translation listing\\).*")
		     ("INBOX.galaxy/broadcasts" "Subject:.*{dgnovice190} Turn .*\\(broadcast message\\).*")
		     ("INBOX.robots" "\\(From\\|To\\):.*\\(nagios\\|postmaster\\|usenet\\|root\\|news\\|mail\\|apache\\|admin\\)\\@")
		     ("INBOX.robots" "From:.*\\(ErrorReporting\\|billing\\)\\@zanby.com")
		     ("INBOX.lists.everyone.ibsys.com" "To:.*everyone@ibsys.com.*")
		     ("INBOX.lists.\\1\.warecorp.com" "List-Id:[^<]*<\\(.*\\)\.warecorp.com>")
		     ("INBOX.jobs@warecorp.com" "To:.*jobs@warecorp.com")
		     ("INBOX.junk" "X-Spam-Status:.*Yes")
		     ("INBOX.junk" "From:.*\\(lisuha\\|karina\\).*solo.by"))))))

;; (setq nnmail-expiry-wait-function
;;       (lambda (group)
;; 	(cond ((string= group "INBOX") 90)
;; 	      ((string= group "INBOX.junk") 7)
;; 	      ((string= group "INBOX.robots") 14)
;; 	      ((string-match "INBOX.lists..*"  group) 90)
;; 	      (t 6))))

;; (setq nnmail-expiry-target 'nnmail-fancy-expiry-target
;;       nnmail-fancy-expiry-targets
;;       '(("list-id" "[^<]*<\\(.*\\)>" "ARCHIVE-lists.\\1-%Y")
;; 	("from" ".*" "ARCHIVE-%Y")))

(setq gnus-parameters
      '((".*junk\\|robots.*"
	 (expiry-target 'delete))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Сохранение сообщений
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq gnus-message-archive-group
      '((lambda (x)
	  (cond
	   ((string-match ".*wc:.*" group)
	    "nnimap+wc:INBOX.sent-mail")
	   (t "nnimap+gmail.com:INBOX.sent-mail")))))

;; `gnus-gcc-mark-as-read'
;;      If non-`nil', automatically mark `Gcc' articles as read.
(setq gnus-gcc-mark-as-read t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Устанавливаем хуки
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Запускается после вставки заголовков, но перед вставкой квотинга
;;
(add-hook 'message-setup-hook
          '(lambda ()
	     (local-set-key [return] 'SNP:break-cited-line)
             (local-set-key "\C-cb" 'GAU:box-region-with-title)))

;;
;; Запускается при отображении сообщения
;;
(add-hook 'gnus-article-display-hook
          '(lambda ()
             (gnus-article-highlight)
             (gnus-article-hide-headers-if-wanted)
             (gnus-article-hide-boring-headers)
             (gnus-article-maybe-highlight)))

(add-hook 'message-mode-hook
          '(lambda ()
             (auto-fill-mode 1)
             (setq fill-column 78)
             (flyspell-mode 1)))
;;
;; Запускается при прорисовке групп, устанавливает разбивку групп по тематике.
;;
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;;    `bbdb-insinuate-gnus' adds bindings for the default keys to Gnus and
;; configures Gnus to notify the BBDB when new messages are loaded.  This
;; notification is required if the BBDB is to be able to display BBDB
;; entries for messages displayed in Gnus.
;;(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)


;; HACK:
(defun pgg-insert-url-with-w3 (url)
  (require 'url)
  (let (buffer-file-name)
    (url-insert-file-contents url)))


;; (add-hook
;;  'message-send-hook
;;  (lambda ()
;;    (cond ((message-mail-p)
;;           (let ((toheader (message-fetch-field "To")))
;;             (let ((recipient (nth 1 (mail-extract-address-components toheader nil))))
;;               (message recipient)
;;               (cond ((and (not (null recipient))
;;                           (or
;;                            (pgg-lookup-key recipient)
;;                            (and
;;                             (pgg-fetch-key pgg-default-keyserver-address recipient)
;;                             (pgg-lookup-key recipient)) ;; we might have added some keys but not the right one ! so we need to check the local base again
;; 			   )
;; 			  (not (message-fetch-field "CC")))
;;                      (mml-secure-message-encrypt-pgpmime))
;;                     (t
;;                      (mml-secure-message-sign-pgpmime))))))
;;          ((message-news-p)
;;           (mml-secure-message-sign-pgpmime)))))

(setq mail-user-agent 'gnus-user-agent)	; mail with gnus user agent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Приветствие, `... wrote:', нормальное цитирование
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun SNP:citation-line ()
  (let ((name-from (SNP:email->stripped-full-name
                    (mail-header-from message-reply-headers)))
        (name-to (message-fetch-reply-field "X-Comment-To")))
    (insert "Hello " (SNP:full-name->first-name name-from) ".\n\n")
    (insert "## On " (mail-header-date message-reply-headers) "\n")
    (if (string-match "^To: " (buffer-string))
          (insert "## you wrote:\n\n")
      (progn
        (insert "## " name-from " wrote")
        (when name-to
          (insert " to " (SNP:email->stripped-full-name name-to)))
        (insert ":\n\n")))))


;; Based on code by Sergey Dolin <dsa-ugur@chel.surnet.ru>
;; and message-indent-citation function of Gnus
(defun SNP:citation ()
  (let ((beg (point))
        (end (mark t))
        (initials (SNP:full-name->initials
                   (SNP:email->stripped-full-name
                    (message-fetch-reply-field "From")))))
    (save-excursion
      (narrow-to-region beg end)

      ;; Удалим заголовки
      (goto-char (point-min))
      (search-forward "\n\n")
      (delete-region (point-min) (point))

      ;; Удалим пустые строки в начале текста...
      (while (and (point-min)
                  (eolp)
                  (not (eobp)))
        (message-delete-line))

      ;; ... и в конце текста
      (goto-char (point-max))
      (unless (eolp)
        (insert "\n"))
      (while (and (zerop (forward-line -1))
                  (looking-at "$"))
        (message-delete-line))

      ;; Собственно цитирование
      (goto-char beg)
      (while (not (eobp))
        ;; Заменим табуляции на пробелы
        (beginning-of-line)
        (while (re-search-forward "\011" (point-at-eol) t)
          (replace-match "        "))

        ;; Отквотим
        (beginning-of-line)
        (unless (eolp)
          (if (not SNP:quote-initials)
              (insert "> ")
            (if (re-search-forward "^ *\\([a-zA-ZЮ-Ъю-ъ]*\\)\\(>+\\)" (point-at-eol) t)
                (replace-match " \\1>\\2")
              (insert " " initials "> "))))

        (next-line 1))
      (widen))
    (insert "\n")))

(defun SNP:break-cited-line ()
  (interactive)
  (if (or (bolp) (eolp))
      (insert "\n")
    (let ((quote-string nil))
      (save-excursion
        (beginning-of-line)
        (when (re-search-forward "^ *[a-zA-Zю-ъЮ-Ч]*>+" (point-at-eol) t)
          (setq quote-string (match-string 0))))
      (if quote-string
          (insert (concat "\n" quote-string))
        (insert "\n")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Разные полезные функции
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Удалить пробелы в начале и в конце строки
;;
(defun SNP:strip-string (str)
  (let ((s str))
    (when (string-match "^[ \"]+" s)
      (setq s (substring s (match-end 0))))
    (when (string-match "[ \"]+$" s)
      (setq s (substring s 0 (match-beginning 0))))
    (symbol-value 's)))

;;
;; Получить имя из e-mail'а
;;
(defun SNP:email->full-name (from)
  (let ((s))
    (if (cdr (setq s (split-string from "<\\|>")))
        (car s)
      (if (cdr (setq s (split-string from "\(\\|\)")))
          (cadr s)
        from))))

(defun SNP:email->stripped-full-name (from)
  (SNP:strip-string (SNP:email->full-name from)))

;;
;; Получить начало имени из полного имени
;;
(defun SNP:full-name->first-name (name)
  (when (string-match "[^ ]*" name)
    (substring name (match-beginning 0) (match-end 0))))

;;
;; Получить инициалы из имени
;;
(defun SNP:full-name->initials (name)
  (let ((lst (split-string name " +"))
        (out ""))
    (while lst
      (setq out (concat out (char-to-string (car (string-to-list (car lst))))))
      (setq lst (cdr lst))
      )
    (symbol-value 'out)))

(defun SNP:generate-signature (sig-type)
  (with-temp-buffer
    (call-process (concat (genenv "HOME") "/bin/signature") nil t nil sig-type)
    (buffer-string)))

(defun GAU:box-region-with-title ()
  (interactive)
  (let ((title (read-from-minibuffer "Title: ")))
    (boxquote-region (region-beginning) (region-end))
     (boxquote-title title)))

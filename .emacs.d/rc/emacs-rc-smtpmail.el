;;;emacs-rc-smtpmail.el --- 

;; Copyright (C) 2009  Aleksei Gusev <aleksei.gusev@warecorp.com>

;; Author: Aleksei Gusev <aleksei.gusev@warecorp.com>
;; Created: 12 May 2009
;; Version: $Id$
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; 

;;; Code:
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


;;; emacs-rc-smtpmail.el ends here

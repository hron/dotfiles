;;;emacs-rc-tramp.el --- TRAMP package customization.

;; Copyright (C) 2005, 2007  Aleksei Gusev <aleksei.gusev@tut.by>

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
;; Created: 26 Aug 2005
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


(setq tramp-shell-prompt-pattern shell-prompt-pattern
      tramp-backup-directory-alist backup-directory-alist
      tramp-auto-save-directory "~/.emacs.d/tramp-auto-save")

(setq tramp-default-host "localhost")
(setq tramp-default-method-alist
			'(( nil "root" "sudo")
				( nil nil "sshx")))

(unless (string-match "22\\." (version))
    (progn
      (setq tramp-default-proxies-alist nil)

      (add-to-list 'tramp-default-proxies-alist
									 '( "10.9.2.4\\|10.9.2.132" nil "/sshx:fw3.warecorp.com:"))

      ;; Zanby farm
      (add-to-list 'tramp-default-proxies-alist
									 '( "^\\(main2\\|zdb\\|mail-\\(00\\|01\\)\\|http-0[0-9]\\)+$" nil "/sshx:fw2.zanby.com:"))

			;; Local zanby farm
      (add-to-list 'tramp-default-proxies-alist
									 '( "^\\(lzdb\\|lzmail-\\(00\\|01\\)\\|lzhttp-0[0-9]\\)+$" nil "/sshx:lzfw1.garage.bogus:"))

      ;; ATZ farm
      (add-to-list 'tramp-default-proxies-alist
									 '( "^atz-\\(nfs\\|mail\\|http\\).*$" nil "/sshx:atz-fw-00.warecorp.com:"))

			;; CPP farm
			(add-to-list 'tramp-default-proxies-alist
									 '( "cpp-\\(db-00\\|mail-0[01]\\|http-0[01]\\)" nil "/sshx:atz-fw-00.warecorp.com:"))

      (add-to-list 'tramp-default-proxies-alist
									 '( "^cd-prod$" nil "/sshx:atz-fw-00.warecorp.com:"))

      ;; Soapblox
      (add-to-list 'tramp-default-proxies-alist
									 '( "^10.101.0.1[0123]$" nil "/sshx:atz-fw-01.warecorp.com:"))


      (add-to-list 'tramp-default-proxies-alist
									 '( nil "root" "/sshx:%h:"))

      (add-to-list 'tramp-default-proxies-alist
									 '( "\\(crystal\\|localhost\\)" "root" nil))

			(add-to-list 'tramp-default-proxies-alist
									 '( "192.168.100.107" "root" "/sshx:devteam@%h:"))

			(add-to-list 'tramp-default-proxies-alist
									 '( "192.168.100.107" "root" "/sshx:devteam@%h:"))

			;; Old soapblox boxes (direct login with root)
			(add-to-list 'tramp-default-proxies-alist
									 '( ".*.soapblox.net" "root" nil))

      (add-to-list 'tramp-default-proxies-alist
									 '( "\\(localhost\\|crystal\\)" "root" nil))

      ))

;;; emacs-rc-tramp.el ends here

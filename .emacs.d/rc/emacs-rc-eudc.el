;;; emacs-rc-eudc.el --- EUDC customization.

;; Copyright (C) 2006, 2007, 2008  Warecorp

;; Author: Aleksei Gusev <aleksei.gusev@warecorp.com>
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
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;

;;; Code:

(require 'ldap)
(setq ldap-default-host "warecorp.com")
(setq ldap-default-base "dc=warecorp, dc=com")
(setq ldap-ldapsearch-args (quote ("-tt" "-LLL" "-x")))

(require 'eudc)

(setq eudc-default-return-attributes nil
      eudc-strict-return-matches nil)

(setq eudc-inline-expansion-format '("%s %s <%s>" givenName name email))
(setq eudc-inline-query-format '((name)
                                 (firstname)
                                 (firstname name)
                                 (email)
                                 ))

(setq ldap-host-parameters-alist
      (quote (("warecorp.com" base "dc=warecorp,dc=com"
               binddn "cn=Aleksei Gusev,ou=People,dc=warecorp,dc=com"
               passwd "dfhtrjhgeyb["))))

(eudc-set-server "warecorp.com" 'ldap t)
(setq eudc-server-hotlist '(("warecorp.com" . ldap)))

(setq eudc-inline-expansion-servers 'hotlist)

(defun enz-eudc-expand-inline()
  (interactive)
  (move-end-of-line 1)
  (insert "*")
  (unless (condition-case nil
              (eudc-expand-inline)
            (error nil))
    (backward-delete-char-untabify 1)))

;; Adds some hooks

(eval-after-load "message"
  '(define-key message-mode-map (kbd "TAB") 'enz-eudc-expand-inline))
(eval-after-load "sendmail"
  '(define-key mail-mode-map (kbd "TAB") 'enz-eudc-expand-inline))
(eval-after-load "post"
  '(define-key post-mode-map (kbd "TAB") 'enz-eudc-expand-inline))

;;; emacs-rc-eudc.el ends here

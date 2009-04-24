;;; emacs-rc-ldap.el --- LDAP customization.

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

(setq ldap-default-host "buick")
(setq ldap-default-base "dc=warecorp, dc=com")

;; *A list of additional arguments to pass to `ldapsearch'.
;; It is recommended to use the `-T' switch with Nescape's
;; implementation to avoid line wrapping.
;; (setq ldap-ldapsearch-args '( "-LLL"))

(setq ldap-host-parameters-alist
      '(("buick"
         base "dc=warecorp, dc=com"
         binddn "cn=Aleksei Gusev, ou=People, dc=warecorp, dc=com"
         passwd "dfhtrjhgeyb["
         auth simple
         scope subtree)
        ("warecorp.com"
         base "dc=warecorp, dc=com"
         binddn "cn=Aleksei Gusev, ou=People, dc=warecorp, dc=com"
         passwd "dfhtrjhgeyb["
         auth simple
         scope subtree)))


;;; emacs-rc-ldap.el ends here

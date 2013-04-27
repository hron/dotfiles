;;;emacs-rc-tramp.el --- TRAMP package customization.

;; Copyright (C) 2005, 2007  Aleksei Gusev <aleksei.gusev@gmail.com>

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
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
(require 'tramp)

(setq shell-prompt-pattern "^.*[#$%>] *")

(setq tramp-backup-directory-alist backup-directory-alist
      tramp-auto-save-directory "~/.emacs.d/tramp-auto-save")

(setq tramp-default-host "localhost")
(setq tramp-default-method-alist
      '(( nil "root" "sudo")
	( nil nil "ssh")))

(unless (string-match "22\\." (version))
  (progn
    (setq tramp-default-proxies-alist nil)

    (add-to-list 'tramp-default-proxies-alist
                 '(nil "root" "/ssh:%h:"))

    (add-to-list 'tramp-default-proxies-alist
                 '("\\(wyvoxapp.com\\|spinstudioapp.com\\)" "deployer" "/ssh:aleksei@%h:"))

    (add-to-list 'tramp-default-proxies-alist
                 '("sfa\\(25\\|36\\|37\\|39\\)" "production" "/ssh:aleksei@%h:"))

    (add-to-list 'tramp-default-proxies-alist
                 '("sfa15" "root" "/ssh:aleksei@fire.boutiqueair.com:"))

    (add-to-list 'tramp-default-proxies-alist
                 '("sfa35" "\\(cruise\\|staging\\|production\\|proto\\|jenkins\\)" "/ssh:aleksei@%h:"))

    ;; (add-to-list 'tramp-default-proxies-alist
    ;;              '("\\(sfa\\(02\\|03\\|04\\|05\\|06\\|07\\|08\\|09\\|10\\|11\\|12\\|13\\|14\\|15\\|16\\|17\\|18\\|19\\|22\\|23\\|24\\|26\\|27\\|28\\|29\\|30\\|31\\|32\\|33\\|34\\)\\)" "root" nil))

    (add-to-list 'tramp-default-proxies-alist
                 '("\\(10\.13\.13\.102\\)" "root" nil))

    (add-to-list 'tramp-default-proxies-alist
                 '("\\(localhost\\)" "root" nil))

    (add-to-list 'tramp-default-proxies-alist
                 '("\\(192\.168\.56\.101\\)" "root" nil))

    ))

(add-hook 'kill-emacs-hook 'tramp-cleanup-all-buffers)

(provide 'emacs-rc-tramp)

;;; emacs-rc-tramp.el ends here

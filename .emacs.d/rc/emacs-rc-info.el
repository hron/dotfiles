;;; emacs-rc-info.el --- 

;; Copyright (C) 2003 Alex Ott
;;
;; Author: ott@jet.msk.su
;; Version: $Id: emacs-rc-info.el,v 0.0 2003/11/20 08:06:48 ott Exp $
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;; (setq
;;  Info-directory-list
;;  '(
;;    "/usr/share/info/"
;;    "/home/ott/info/"
;;    "/usr/local/info/"
;;    )
;;  )
;; Add bzip2 suffixes to info reader.
(require 'info)
(setq Info-suffix-list
      (append '(
		(".info.bz2" . "bzip2 -dc %s")
		(".bz2"      . "bzip2 -dc %s"))
	      Info-suffix-list))

;;; emacs-rc-info.el ends here

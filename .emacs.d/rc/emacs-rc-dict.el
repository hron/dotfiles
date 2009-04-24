;;; emacs-rc-dict.el ---

;; Copyright (C) 2003 Alex Ott
;;
;; Author: ott@jet.msk.su
;; Version: $Id: emacs-rc-dict.el,v 0.0 2003/11/20 07:54:45 ott Exp $
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(add-to-list 'load-path "/home/aleksei/.emacs.d/dict/")
(autoload 'dictionary-search "dictionary"
  "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary"
  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
  "Create a new dictionary buffer" t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary"
  "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary"
  "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary"
  "Display tooltips for the current word" t)
(autoload 'global-dictionary-tooltip-mode "dictionary"
  "Enable/disable dictionary-tooltip-mode for all buffers" t)

(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)
(global-set-key "\C-cd" 'dictionary-lookup-definition)

;; Popup menu for GNU Emacs 21, and XEmacs 21
(if (boundp 'running-xemacs)
    (global-set-key [(control button3)] 'dictionary-mouse-popup-matching-words)
   (global-set-key [mouse-3] 'dictionary-mouse-popup-matching-words))

(setq dictionary-tooltip-dictionary "mueller7")
;; (global-dictionary-tooltip-mode t)

(setq dictionary-server "localhost")
(setq dictionary-default-dictionary "mueller7")
(setq dictionary-default-popup-strategy "lev")

(add-hook 'dictionary-mode-hook
	  '(lambda ()
	     (local-set-key [backspace] 'scroll-down)))

;;; emacs-rc-dict.el ends here

;;; emacs-rc-mule.el --- 

;; Copyright (C) 2003, 2007 Alex Ott
;;
;; Author: ott@jet.msk.su
;; Version: $Id: emacs-rc-mule.el,v 0.0 2003/11/20 07:58:49 ott Exp $
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(setq default-input-method "russian-computer")
(setq english-layout-key (kbd "C-2")
      russian-layout-key (kbd "C-1"))
;; (setq english-layout-key (kbd "s-o")
;;       russian-layout-key (kbd "s-i"))
;; (setq english-layout-key (kbd "<XF86Forward>")
;;       russian-layout-key (kbd "S-<XF86Forward>"))


(global-set-key english-layout-key '(lambda () (interactive) (inactivate-input-method)))
(global-set-key russian-layout-key '(lambda () (interactive) (unless current-input-method
						      (toggle-input-method))))
(define-key isearch-mode-map english-layout-key '(lambda () (interactive) (if current-input-method
								 (isearch-toggle-input-method) (isearch-update))))
(define-key isearch-mode-map russian-layout-key '(lambda () (interactive) (if current-input-method
								 (isearch-update) (isearch-toggle-input-method))))

(provide 'emacs-rc-mule)

;;; emacs-rc-mule.el ends here

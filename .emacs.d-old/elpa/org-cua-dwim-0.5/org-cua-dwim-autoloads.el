;;; org-cua-dwim-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (org-cua-dwim-turn-on-org-cua-mode-partial-support)
;;;;;;  "org-cua-dwim" "org-cua-dwim.el" (20266 48570))
;;; Generated autoloads from org-cua-dwim.el

(autoload 'org-cua-dwim-turn-on-org-cua-mode-partial-support "org-cua-dwim" "\
This turns on org-mode cua-mode partial support; Assumes
shift-selection-mode is available.

\(fn)" t nil)

(add-hook 'org-mode-hook 'org-cua-dwim-turn-on-org-cua-mode-partial-support)

;;;***

;;;### (autoloads nil nil ("org-cua-dwim-pkg.el") (20266 48570 844811))

;;;***

(provide 'org-cua-dwim-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-cua-dwim-autoloads.el ends here

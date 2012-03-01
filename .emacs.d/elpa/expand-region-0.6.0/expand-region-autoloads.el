;;; expand-region-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (er/expand-region) "expand-region" "expand-region.el"
;;;;;;  (20303 43798))
;;; Generated autoloads from expand-region.el

(autoload 'er/expand-region "expand-region" "\
Increase selected region by semantic units.
Basically it runs all the mark-functions in `er/try-expand-list'
and chooses the one that increases the size of the region while
moving point or mark as little as possible.

With prefix argument expands the region that many times.
If prefix argument is negative calls `er/contract-region'.
If prefix argument is 0 it resets point and mark to their state
before calling `er/expand-region' for the first time.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("clojure-mode-expansions.el" "css-mode-expansions.el"
;;;;;;  "erlang-mode-expansions.el" "expand-region-pkg.el" "feature-mode-expansions.el"
;;;;;;  "html-mode-expansions.el" "js-mode-expansions.el" "latex-mode-expansions.el"
;;;;;;  "python-mode-expansions.el" "ruby-mode-expansions.el" "text-mode-expansions.el")
;;;;;;  (20303 43799 376507))

;;;***

(provide 'expand-region-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; expand-region-autoloads.el ends here

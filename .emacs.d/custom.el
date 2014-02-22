(put 'scroll-left 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(background-color "#fdf6e3")
 '(background-mode light)
 '(canlock-password "e6a803bd4bbe7baa935108fb943f3df19651b148")
 '(cursor-color "#657b83")
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(foreground-color "#657b83")
 '(safe-local-variable-values (quote ((ruby-test-specification-filename-mapping ("\\(.*\\)\\(lib/active_merchant/billing/gateways/\\)\\(.*\\)\\(\\.rb\\)$" "\\1test/unit/gateways/\\3_test\\4")) (ruby-test-specification-filename-mapping ("\\(.*\\)\\(lib/active_merchant/billing/gateways/\\)\\(.*\\)\\([^/]*\\)\\(\\.rb\\)$" "\\1test/unit/gateways/\\3_test\\4\\5")) (ruby-test-implementation-filename-mapping ("\\(.*\\)\\(test/unit/gateways/\\)\\(.*\\)\\([^/]*\\)\\(_test\\)\\(\\.rb\\)$" "\\1lib/active_merchant/billing/gateways/\\3\\4\\6")) (ruby-test-implementation-filename-mapping ("\\(.*\\)\\(test/unit/gateways//\\)\\(.*\\)\\([^/]*\\)\\(_test\\)\\(\\.rb\\)$" "\\1lib/active_merchant/billing/gateways/\\3\\4\\6")) (ruby-test-specification-filename-mapping ("\\(.*\\)\\(lib/active_merchant/billing/gateways\\)\\(.*\\)\\([^/]*\\)\\(\\.rb\\)$" "\\1test/unit/gateways/\\3_test\\4\\5")) (css-indent-offset . 2) (org-not-done-heading-regexp . "^\\(\\*+\\)\\(?: +\\(TODO\\|George\\|Nila\\|Matt\\|Shawn\\|Lena\\|Ded\\|Sasha\\|Mikhaylovsky\\|Pavel\\|Slava\\|Sergey\\|Shostak\\|Mama\\|Mikhnovets\\|WAIT\\)\\)\\(?: +\\(.*?\\)\\)?[	]*$") (org-export-html-postamble) (encoding . binary) (erlang-indent-level . 4) (ruby-test-implementation-filename-mapping ("\\(.*\\)\\(spec/\\)\\(.*\\)\\([^/]*\\)\\(_spec\\)\\(\\.rb\\)$" "\\1lib/\\3\\4\\6")) (ruby-test-implementation-filename-mapping ("\\(.*\\)\\(spec/\\)\\(.*\\)\\([^/]*\\)\\(_spec\\)\\(\\.rb\\)$" "\\1lib/\\2\\3\\4\\5")) (ruby-test-specification-filename-mapping ("\\(.*\\)\\(lib\\)\\(.*\\)\\([^/]*\\)\\(\\.rb\\)$" "\\1spec/\\3_spec\\4\\5")) (ruby-test-specification-filename-mapping (("\\(.*\\)\\(lib\\)\\(.*\\)\\([^/]*\\)\\(\\.rb\\)$" "\\1spec/\\3_spec\\4\\5"))) (ruby-test-specification-filename-mapping (quote (("\\(.*\\)\\(lib\\)\\(.*\\)\\([^/]*\\)\\(\\.rb\\)$" "\\1spec/\\3_spec\\4\\5")))) (require-final-newline) (tags-file-name . "TAGS") (encoding . utf-8) (ispell-dictionary . "russian") (eeb-defaults eeel4r ee-delimiter-hash nil t t) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby") (test-script . "../testing/test-el4r.rb") (modes ruby-mode emacs-lisp-mode) (phpunit-run-directory . "/home/gusev/src/z/zanby/core") (js2-strict-missing-semi-warning) (js2-strict-missing-semi-warning . 100) (c-hanging-comment-ender-p) (folded-file . t) (folding-internal-margins) (sgml-omittag . t) (sgml-shorttag . t) (sgml-minimize-attributes) (sgml-always-quote-attributes . t) (sgml-indent-step . 2) (sgml-indent-data . t) (sgml-parent-document) (sgml-default-dtd-file) (sgml-exposed-tags) (sgml-local-catalogs) (sgml-local-ecat-files) (encoding . koi8-r))))
 '(solarized-height-minus-1 1.0)
 '(solarized-height-plus-1 1.0)
 '(solarized-height-plus-2 1.0)
 '(solarized-height-plus-3 1.0)
 '(solarized-height-plus-4 1.0)
 '(solarized-use-variable-pitch nil))
(put 'set-goal-column 'disabled nil)
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "white" :foreground "#221f1e" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :weight normal :height 143 :width normal :foundry "unknown" :family "Ubuntu Mono"))))
;;  '(flyspell-duplicate ((t (:underline (:color "red" :style wave)))))
;;  '(flyspell-incorrect ((t (:underline (:color "red" :style wave))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:weight normal :height 140 :width normal :foundry "unknown" :family "Ubuntu Mono"))))
 '(flyspell-duplicate ((t (:underline (:color "red" :style wave)))))
 '(flyspell-incorrect ((t (:underline (:color "#dc322f" :style wave)))))
 '(org-level-1 ((t (:inherit variable-pitch :foreground "#cb4b16"))))
 '(org-level-2 ((t (:inherit variable-pitch :foreground "#859900"))))
 '(org-level-3 ((t (:inherit variable-pitch :foreground "#268bd2"))))
 '(org-level-4 ((t (:inherit variable-pitch :foreground "#b58900"))))
 '(variable-pitch ((t (:height 140 :family "Ubuntu")))))

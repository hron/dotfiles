;;; ~/.emacs.d/init.el

;; Copyright (C) 2004, 2005, 2006,
;;               2007, 2008, 2009 Aleksei Gusev <aleksei.gusev@gmail.com>

;; Started: 1 June 2004
;; Version: $Id$


;; Add some dirs to load-path
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir (expand-file-name "~/.emacs.d/site-lisp/"))
           (default-directory my-lisp-dir))
      (progn
	(setq load-path (cons my-lisp-dir load-path))
	(normal-top-level-add-subdirs-to-load-path))))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rc"))

(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(require 'server)

;;----------------------------------------------------------------------------
;; Handier way to add modes to auto-mode-alist
;;----------------------------------------------------------------------------
(defun add-auto-mode (mode &rest patterns)
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

;; Shell
(require 'emacs-rc-sh)

;; Emacs-Lisp
(add-hook 'emacs-lisp-mode-hook '(lambda ()
                                   (turn-on-auto-fill)
                                   (flyspell-prog-mode)
                                   ;; (turn-on-orgstruct)
                                   ;; (turn-on-orgtbl)
                                   (highlight-parentheses-mode 1)))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)


;; Text
(add-hook 'text-mode-hook '(lambda ()
                             (turn-on-auto-fill)
                             (turn-on-flyspell)
                             ;; (turn-on-orgstruct)
                             ;; (turn-on-orgtbl)
                             (highlight-parentheses-mode 1)))

;; Java script
(setq js-indent-level 2)

;; Apache
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

;; Markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Regex-tool
(autoload 'regex-tool "regex-tool" "Mode for exploring regular expressions" t)

;; Git
(autoload 'git-blame-mode "git-blame" "Minor mode for incremental blame for Git." t)

;; Ruby
(require 'emacs-rc-ruby)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (flyspell-prog-mode)
             ;; (turn-on-orgstruct)
             ;; (turn-on-orgtbl)
             (highlight-parentheses-mode 1)))

;; htmlize
(dolist (sym
         (list 'htmlize-file 'htmlize-region 'htmlize-buffer
               'htmlize-many-files 'htmlize-many-files-dired))
  (autoload sym "htmlize"))

;; SQL
;; (eval-after-load "sql"
;;   '(load-library "sql-indent"))
(setq sql-sqlite-program "sqlite3")

;; ANSI colors
(require 'ansi-color)
(setq ansi-color-names-vector
      ["black" "red" "green" "yellow" "LightSkyBlue" "magenta" "cyan" "white"])
(setq ansi-color-map (ansi-color-make-color-map))

(require 'emacs-rc-tty-format)

;; Anything
(require 'emacs-rc-anything)

;; magit
(require 'magit)

;; This is a redefinition of `magit-status' which use `switch-to-buffer' instead
;; of `pop-to-buffer'.
;;;###autoload
(defun magit-status (dir)
  (interactive (list (or (and (not current-prefix-arg)
                              (magit-get-top-dir default-directory))
                         (magit-read-top-dir (and (consp current-prefix-arg)
                                                  (> (car current-prefix-arg) 4))))))
  (magit-save-some-buffers)
  (let ((topdir (magit-get-top-dir dir)))
    (unless topdir
      (when (y-or-n-p (format "There is no Git repository in %S.  Create one? "
                              dir))
	(magit-init dir)
	(setq topdir (magit-get-top-dir dir))))
    (when topdir
      (let ((buf (or (magit-find-buffer 'status topdir)
                     (generate-new-buffer
                      (concat "*magit: "
                              (file-name-nondirectory
                               (directory-file-name topdir)) "*")))))
        (switch-to-buffer buf)
        (magit-mode-init topdir 'status #'magit-refresh-status)
        (magit-status-mode t)))))

;; http://www.emacswiki.org/emacs/ToggleWindowSplit
(require 'toggle-window-split)

;; Yasnippet
(require 'yasnippet)
(setq yas/snippet-dirs "~/.emacs.d/site-lisp/yasnippet-snippets")
(yas/load-snippet-dirs)
(yas/global-mode t)

;; ;; nXhtml
;; (load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; ;; This prevents activating nxhtml-mode for .html.haml files.
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo-mode))
;; (add-to-list 'auto-mode-alist '("\\.html\\.haml\\'" . haml-mode))

(setq aug-secret-file "~/.emacs.d/.secret-file")
(load aug-secret-file t)

;; Coffescript
(setq coffee-tab-width 2)
(add-hook 'coffee-mode-hook '(lambda ()
                               (make-variable-buffer-local 'electric-indent-chars)
                               (setq electric-indent-chars '())
                               (define-key coffee-mode-map (kbd "C-c C-s") 'coffee-repl)))

(add-auto-mode 'nginx-mode "nginx.conf$")


(add-hook 'feature-mode-hook '(lambda ()
                               (make-variable-buffer-local 'electric-indent-chars)
                               (setq electric-indent-chars '())))

(require 'ibus)
;; (add-hook 'after-init-hook 'ibus-mode-on)
(ibus-mode-on)
(global-set-key (kbd "S-<delete>") 'ibus-toggle)
(global-set-key (kbd "S-<return>") 'ibus-toggle)

;;
;; Emacs core customization
;;

;; Orgmode
(require 'emacs-rc-org)

;; Spelling
(setq ispell-dictionary "en_US")

;; Filladapt
(setq-default filladapt-mode t)

(require 'emacs-rc-compilation)

;; comint-mode
(setq comint-scroll-to-bottom-on-output 'others)
;; for zsh extended history...
(setq comint-input-ring-separator "\\(\n\\|:[[:space:]]+[[:digit:]]+:[[:digit:]]+;\\)")

(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

(require 'emacs-rc-shell)

(setq large-file-warning-threshold 30000000)

(require 'emacs-rc-flymake)
(require 'emacs-rc-ido)
(require 'emacs-rc-decor)
(require 'emacs-rc-dired)
(require 'emacs-rc-hippie-exp)
(require 'emacs-rc-gdb)
;; BUG: Tramp sudo does not work with this hack.
;; (require 'emacs-rc-mule)
(require 'emacs-rc-tramp)
(require 'emacs-rc-woman)
(require 'emacs-rc-view)

(electric-pair-mode)
;; Does not work good in cucumber mode and haml.
(electric-layout-mode)
(electric-indent-mode)

(require 'emacs-rc-user-info)
(require 'emacs-rc-kbd)

;; Everything else...
;; FIXME: When I do yank on selected region yanked test does not appear.
(require 'emacs-rc-misc-things)

(setq flyspell-use-meta-tab nil)

;; (require 'hideshow)
;; (setq hs-allow-nesting t)
;;
;; (defun hs-gau-hide-level-deeply (arg)
;;   "Hide all blocks deeper that ARG level below the top of file."
;;   (interactive "p")
;;   (let* ((max-level 5)
;;          (level-to-hide max-level))
;;     (save-excursion
;;       (goto-char (point-min))
;;       (hs-show-all)
;;       (while (>= level-to-hide arg)
;;	(save-excursion
;;           (hs-hide-level level-to-hide)
;;           (setq level-to-hide (1- level-to-hide)))))))
;;
;; (defun hs-gau-toggle-hiding-or-hide-level (level)
;;   (interactive "P")
;;   (if level
;;       (hs-gau-hide-level-deeply level)
;;     (hs-toggle-hiding)))
;;
;;
;; (add-hook 'hs-minor-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "<C-tab>") 'hs-gau-toggle-hiding-or-hide-level)))

(require 'color-theme)

;; ;; Color theme loading, must be the last.
(load-library "color-themes/color-theme-dark-hron")
(color-theme-dark-hron)

;; (require 'color-theme-solarized)
;;
;; ;; (magit-item-highlight ((t (:background "#0a2832"))))
;; (defun solarized-color-definitions (mode)
;;   (flet ((find-color (name)
;;            (let ((index (if window-system
;;                             (if solarized-degrade
;;                                 3
;;                               2)
;;                           (if (= solarized-termcolors 256)
;;                               3
;;                             4))))
;;              (nth index (assoc name solarized-colors)))))
;;     (let ((base03    (find-color 'base03))
;;           (base02    (find-color 'base02))
;;           (base01    (find-color 'base01))
;;           (base00    (find-color 'base00))
;;           (base0     (find-color 'base0))
;;           (base1     (find-color 'base1))
;;           (base2     (find-color 'base2))
;;           (base3     (find-color 'base3))
;;           (yellow    (find-color 'yellow))
;;           (orange    (find-color 'orange))
;;           (red       (find-color 'red))
;;           (magenta   (find-color 'magenta))
;;           (violet    (find-color 'violet))
;;           (blue      (find-color 'blue))
;;           (cyan      (find-color 'cyan))
;;           (green     (find-color 'green))
;;           (bold      (if solarized-bold 'bold 'normal))
;;           (underline (if solarized-underline t nil))
;;           (opt-under nil)
;;           (italic    (if solarized-italic 'italic 'normal)))
;;       (when (eq 'light mode)
;;         (rotatef base03 base3)
;;         (rotatef base02 base2)
;;         (rotatef base01 base1)
;;         (rotatef base00 base0))
;;       (let ((back base03))
;;         (cond ((eq 'high solarized-contrast)
;;                (let ((orig-base3 base3))
;;                  (rotatef base01 base00 base0 base1 base2 base3)
;;                  (setf base3 orig-base3)))
;;               ((eq 'low solarized-contrast)
;;                (setf back      base02
;;                      opt-under t)))
;;         `((;; basic
;;            (default ((t (:foreground ,base0 ,:background ,back))))
;;            (cursor
;;             ((t (:foreground ,base0 :background ,base03 :inverse-video t))))
;;            (escape-glyph-face ((t (:foreground ,red))))
;;            (fringe ((t (:foreground ,base01 :background ,base02))))
;;            (linum ((t (:foreground ,base01 :background ,base02))))
;;            (header-line ((t (:foreground ,base0 :background ,base2))))
;;            (highlight ((t (:background ,base02))))
;;            (hl-line ((t (:background ,base02))))
;;            (isearch ((t (:foreground ,yellow :inverse-video t))))
;;            (lazy-highlight ((t (:background ,base2 :foreground ,base00))))
;;            (link ((t (:foreground ,violet :underline ,underline))))
;;            (link-visited ((t (:foreground ,magenta :underline ,underline))))
;;            (menu ((t (:foreground ,base0 :background ,base02))))
;;            (minibuffer-prompt ((t (:foreground ,blue))))
;;            (mode-line
;;             ((t (:foreground ,base1 :background ,base02
;;                              :box (:line-width 1 :color ,base1)))))
;;            (mode-line-buffer-id ((t (:foreground ,base1))))
;;            (mode-line-inactive
;;             ((t (:foreground ,base0  :background ,base02
;;                              :box (:line-width 1 :color ,base02)))))
;;            (region ((t (:background ,base02))))
;;            (secondary-selection ((t (:background ,base02))))
;;            (trailing-whitespace ((t (:foreground ,red :inverse-video t))))
;;            (vertical-border ((t (:foreground ,base0))))
;;            ;; comint
;;            (comint-highlight-prompt ((t (:foreground ,blue))))
;;            ;; compilation
;;            (compilation-info ((t (:foreground ,green :weight ,bold))))
;;            (compilation-warning ((t (:foreground ,orange :weight ,bold))))
;;            ;; customize
;;            (custom-button
;;             ((t (:background ,base02
;;                              :box (:line-width 2 :style released-button)))))
;;            (custom-button-mouse
;;             ((t (:inherit custom-button :foreground ,base1))))
;;            (custom-button-pressed
;;             ((t (:inherit custom-button-mouse
;;                           :box (:line-width 2 :style pressed-button)))))
;;            (custom-comment-tag ((t (:background ,base02))))
;;            (custom-comment-tag ((t (:background ,base02))))
;;            (custom-documentation ((t (:inherit default))))
;;            (custom-group-tag ((t (:foreground ,orange :weight ,bold))))
;;            (custom-link ((t (:foreground ,violet))))
;;            (custom-state ((t (:foreground ,green))))
;;            (custom-variable-tag ((t (:foreground ,orange :weight ,bold))))
;;            ;; diff
;;            (diff-added ((t (:foreground ,green :inverse-video t))))
;;            (diff-changed ((t (:foreground ,yellow :inverse-video t))))
;;            (diff-removed ((t (:foreground ,red :inverse-video t))))
;;            (diff-header ((t (:background ,base01))))
;;            (diff-file-header
;;             ((t (:background ,base1 :foreground ,base01 :weight ,bold))))
;;            (diff-refine-change ((t (:background ,base1))))
;;            ;; IDO
;;            (ido-only-match ((t (:foreground ,green))))
;;            (ido-subdir ((t (:foreground ,blue))))
;;            (ido-first-match ((t (:foreground ,green :weight ,bold))))
;;            ;; emacs-wiki
;;            (emacs-wiki-bad-link-face
;;             ((t (:foreground ,red :underline ,underline))))
;;            (emacs-wiki-link-face
;;             ((t (:foreground ,blue :underline ,underline))))
;;            (emacs-wiki-verbatim-face
;;             ((t (:foreground ,base00 :underline ,underline))))
;;            ;; font-lock
;;            (font-lock-builtin-face ((t (:foreground ,green))))
;;            (font-lock-comment-face ((t (:foreground ,base01 :slant ,italic))))
;;            (font-lock-constant-face ((t (:foreground ,cyan))))
;;            (font-lock-function-name-face ((t (:foreground ,blue))))
;;            (font-lock-keyword-face ((t (:foreground ,green))))
;;            (font-lock-string-face ((t (:foreground ,cyan))))
;;            (font-lock-type-face ((t (:foreground ,yellow))))
;;            (font-lock-variable-name-face ((t (:foreground ,blue))))
;;            (font-lock-warning-face ((t (:foreground ,red :weight ,bold))))
;;            (font-lock-doc-face ((t (:foreground ,cyan :slant ,italic))))
;;            (font-lock-color-constant-face ((t (:foreground ,green))))
;;            (font-lock-comment-delimiter-face
;;             ((t (:foreground ,base01 :weight ,bold))))
;;            (font-lock-doc-string-face ((t (:foreground ,green))))
;;            (font-lock-preprocessor-face ((t (:foreground ,orange))))
;;            (font-lock-reference-face ((t (:foreground ,cyan))))
;;            (font-lock-negation-char-face ((t (:foreground ,red))))
;;            (font-lock-other-type-face ((t (:foreground ,blue :slant ,italic))))
;;            (font-lock-regexp-grouping-construct    ((t (:foreground ,orange))))
;;            (font-lock-special-keyword-face ((t (:foreground ,magenta))))
;;            (font-lock-exit-face ((t (:foreground ,red))))
;;            (font-lock-other-emphasized-face
;;             ((t (:foreground ,violet :weight ,bold :slant ,italic))))
;;            (font-lock-regexp-grouping-backslash ((t (:foreground ,yellow))))
;;            ;; info
;;            (info-xref ((t (:foreground ,blue :underline ,underline))))
;;            (info-xref-visited ((t (:inherit info-xref :foreground ,magenta))))
;;            ;; org
;;            (org-hide ((t (:foreground ,base03))))
;;            (org-todo ((t (:foreground ,base03 :background ,red :weight ,bold))))
;;            (org-done ((t (:foreground ,green :weight ,bold))))
;;            (org-todo-kwd-face ((t (:foreground ,red :background ,base03))))
;;            (org-done-kwd-face ((t (:foreground ,green :background ,base03))))
;;            (org-project-kwd-face
;;             ((t (:foreground ,violet :background ,base03))))
;;            (org-waiting-kwd-face
;;             ((t (:foreground ,orange :background ,base03))))
;;            (org-someday-kwd-face ((t (:foreground ,blue :background ,base03))))
;;            (org-started-kwd-face
;;             ((t (:foreground ,yellow :background ,base03))))
;;            (org-cancelled-kwd-face
;;             ((t (:foreground ,green :background ,base03))))
;;            (org-delegated-kwd-face
;;             ((t (:foreground ,cyan :background ,base03))))
;;            ;; show-paren
;;            (show-paren-match-face ((t (:background ,cyan :foreground ,base3))))
;;            (show-paren-mismatch-face
;;             ((t (:background ,red :foreground ,base3))))
;;            ;; widgets
;;            (widget-field
;;             ((t (:box (:line-width 1 :color ,base00) :inherit default))))
;;            (widget-single-line-field ((t (:inherit widget-field))))
;;            ;; extra modules
;;            ;; -------------
;;            ;; gnus
;;            (gnus-cite-1 ((t (:foreground ,magenta))))
;;            (gnus-cite-2 ((t (:foreground ,base2))))
;;            (gnus-cite-3 ((t (:foreground ,base3))))
;;            (gnus-cite-4 ((t (:foreground ,base1))))
;;            (gnus-cite-5 ((t (:foreground ,magenta))))
;;            (gnus-cite-6 ((t (:foreground ,base2))))
;;            (gnus-cite-7 ((t (:foreground ,base3))))
;;            (gnus-cite-8 ((t (:foreground ,base1))))
;;            (gnus-cite-9 ((t (:foreground ,base2))))
;;            (gnus-cite-10 ((t (:foreground ,base3))))
;;            (gnus-cite-11 ((t (:foreground ,blue))))
;;            (gnus-group-mail-1 ((t (:foreground ,base3 :weight ,bold))))
;;            (gnus-group-mail-1-empty ((t (:foreground ,base3))))
;;            (gnus-group-mail-2 ((t (:foreground ,base2 :weight ,bold))))
;;            (gnus-group-mail-2-empty ((t (:foreground ,base2))))
;;            (gnus-group-mail-3 ((t (:foreground ,magenta :weight ,bold))))
;;            (gnus-group-mail-3-empty ((t (:foreground ,magenta))))
;;            (gnus-group-mail-low ((t (:foreground ,base00 :weight ,bold))))
;;            (gnus-group-mail-low-empty ((t (:foreground ,base00))))
;;            (gnus-group-news-1 ((t (:foreground ,base1 :weight ,bold))))
;;            (gnus-group-news-1-empty ((t (:foreground ,base1))))
;;            (gnus-group-news-2 ((t (:foreground ,blue :weight ,bold))))
;;            (gnus-group-news-2-empty ((t (:foreground ,blue))))
;;            (gnus-group-news-low ((t (:foreground ,violet :weight ,bold))))
;;            (gnus-group-news-low-empty ((t (:foreground ,violet))))
;;            (gnus-header-content ((t (:foreground ,cyan :slant ,italic))))
;;            (gnus-header-from ((t (:foreground ,base2))))
;;            (gnus-header-name ((t (:foreground ,blue))))
;;            (gnus-header-newsgroups ((t (:foreground ,green :slant ,italic))))
;;            (gnus-header-subject ((t (:foreground ,base1))))
;;            (gnus-server-agent ((t (:foreground ,base3 :weight ,bold))))
;;            (gnus-server-closed ((t (:foreground ,base1 :slant ,italic))))
;;            (gnus-server-denied ((t (:foreground ,base2 :weight ,bold))))
;;            (gnus-server-offline ((t (:foreground ,green :weight ,bold))))
;;            (gnus-server-opened ((t (:foreground ,cyan :weight ,bold))))
;;            (gnus-splash ((t (:foreground ,base2))))
;;            (gnus-summary-high-ancient
;;             ((t (:foreground ,magenta :weight ,bold))))
;;            (gnus-summary-high-read ((t (:foreground ,base1 :weight ,bold))))
;;            (gnus-summary-high-ticked ((t (:foreground ,base3 :weight ,bold))))
;;            (gnus-summary-high-undownloaded
;;             ((t (:foreground ,base2 :weight ,bold))))
;;            (gnus-summary-low-ancient
;;             ((t (:foreground ,magenta :slant ,italic))))
;;            (gnus-summary-low-read ((t (:foreground ,base1 :slant ,italic))))
;;            (gnus-summary-low-ticked ((t (:foreground ,base3 :slant ,italic))))
;;            (gnus-summary-low-undownloaded
;;             ((t (:foreground ,base2 :slant ,italic))))
;;            (gnus-summary-normal-ancient ((t (:foreground ,magenta))))
;;            (gnus-summary-normal-read ((t (:foreground ,base1))))
;;            (gnus-summary-normal-ticked ((t (:foreground ,base3))))
;;            (gnus-summary-normal-undownloaded ((t (:foreground ,base2))))
;;            ;; Flymake
;;            (flymake-errline ((t (:background ,orange))))
;;            (flymake-warnline ((t (:background ,violet))))
;;            ;; whitespace
;;            (whitespace-empty ((t (:foreground ,red))))
;;            (whitespace-hspace ((t (:foreground ,orange))))
;;            (whitespace-indentation ((t (:foreground ,base02))))
;;            (whitespace-space ((t (:foreground ,base02))))
;;            (whitespace-space-after-tab ((t (:foreground ,cyan))))
;;            (whitespace-space-before-tab ((t (:foreground ,red :weight ,bold))))
;;            (whitespace-tab ((t (:foreground ,base02))))
;;            (whitespace-trailing
;;             ((t (:background ,base02 :foreground ,red :weight ,bold))))
;;            (whitespace-highlight-face
;;             ((t (:background ,blue :foreground ,red))))
;;            ;; Message
;;            (message-mml ((t (:foreground ,blue))))
;;            (message-cited-text ((t (:foreground ,base2))))
;;            (message-separator ((t (:foreground ,base3))))
;;            (message-header-xheader ((t (:foreground ,violet))))
;;            (message-header-name ((t (:foreground ,cyan))))
;;            (message-header-other ((t (:foreground ,red))))
;;            (message-header-newsgroups
;;             ((t (:foreground ,yellow :weight ,bold :slant ,italic))))
;;            (message-header-subject ((t (:foreground ,base00))))
;;            (message-header-cc ((t (:foreground ,green :weight ,bold))))
;;            (message-header-to ((t (:foreground ,base1 :weight ,bold))))
;;            ;; Magit
;;            (magit-item-highlight ((t (:background ,base02)))))
;;           ((foreground-color . ,base0)
;;            (background-color . ,base03)
;;            (background-mode . ,mode)
;;            (cursor-color . ,base0)))))))
;;
;; (color-theme-solarized-dark)

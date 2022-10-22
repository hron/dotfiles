;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aleksei Gusev"
      user-mail-address "aleksei.gusev@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(if (eq system-type 'gnu/linux)
    (setq doom-font "JetBrainsMono Nerd Font-11")
  (setq doom-font "JetBrainsMono NF-11")
  (setq doom-unicode-font "JetBrainsMono NF-11")
  (setq doom-variable-pitch-font "JetBrainsMono NF-11"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map! "C-<f2>" 'list-processes)

(custom-set-faces!
 '(outline-1 :weight normal)
 '(outline-2 :weight normal)
 '(outline-3 :weight normal)
 '(outline-4 :weight normal)
 '(outline-5 :weight normal)
 '(outline-6 :weight normal))

(use-package! iflipb
  :bind (:map global-map
         ("C-<tab>" . iflipb-next-buffer)
         ("<C-iso-lefttab>" . iflipb-previous-buffer)))

(use-package! magit
  :bind (:map magit-section-mode-map
         ("C-<tab>" . nil)
         ("<C-iso-lefttab>" . nil)))

(use-package! smartparens
  :config
  (custom-set-variables
   '(sp-override-key-bindings
     '(("C-<right>" . nil)
       ("C-<left>" . nil)))))

(defun gusev/org-gtd ()
  "Prepare emacs frame to use as a GTD system."
  (interactive)
  (require 'org)
  (dolist (f org-agenda-files)
    (find-file (concat org-directory "/" f)))
  (switch-to-buffer "tasks.org")
  (let ((tasks-icon "/usr/share/icons/Yaru/256x256/apps/org.gnome.Todo.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks")))

(defun gusev/org-capture-system-wide ()
  "System-wide variant of org-capture."
  (interactive)
  (require 'org)
  (org-capture :keys "i")
  (delete-other-windows))

(defun gusev/org-gtd-capture ()
  (interactive)
  (let ((tasks-icon "/usr/share/icons/Yaru/256x256/apps/org.gnome.Todo.png"))
    (set-frame-parameter nil 'icon-type tasks-icon)
    (set-frame-parameter nil 'icon-name "Tasks"))
  (gusev/org-capture-system-wide))

(use-package! org
  :config (progn
            (add-hook 'org-capture-after-finalize-hook 'delete-frame)
            (add-hook 'org-mode-hook '(lambda ()
                                        (toggle-truncate-lines -1)
                                        (toggle-word-wrap +1)))
            ;; (add-hook 'after-save-hook '(lambda ()
            ;;                               (when (eq major-mode 'org-mode)
            ;;                                 (org-caldav-sync)
            ;;                                 (org-caldav-sync))))
            (setq org-tag-alist '(("outside" . ?o)
                                  ("read" . ?r)
                                  ("games" . ?g)
                                  ("shop" . ?s)
                                  ("windows" . ?w)
                                  ("laptop" . ?l)
                                  ("meet" . ?m)
                                  ("emacs" . ?e)
                                  (:startgroup)
                                  ("Elena" . ?E)
                                  (:endgroup)
                                  )

                  org-todo-keywords
                  '((sequence
                     "TODO"
                     "DONE"))
                  org-agenda-scheduled-later-expr "-SCHEDULED>=\"<tomorrow>\"-someday-tickler/"
                  org-agenda-na-expr (concat org-agenda-scheduled-later-expr "TODO")
                  org-agenda-active-expr (concat org-agenda-scheduled-later-expr "-DONE")
                  org-agenda-custom-commands
                  '(("n" "NA" tags-tree org-agenda-na-expr))
                  org-agenda-files '("tasks.org" "f-secure.org" "tickler.org" "inbox.org")
                  org-refile-targets '((org-agenda-files :maxlevel . 2) (("someday.org") :maxlevel . 1))
                  org-archive-location (concat "archive/" (format-time-string "%Y") ".org::")
                  org-archive-default-command 'org-archive-subtree
                  org-capture-templates
                  '(("i" "Todo" entry (file "~/org/inbox.org")
                     "* %?\n  :PROPERTIES:\n  :Added: %U\n  :END:\n  %i\n  %a"))
                  org-agenda-start-on-weekday 1
                  calendar-week-start-day 1
                  )

            (defun gusev/org-todo-convert-to-project ()
              (interactive)
              (save-excursion
                (org-todo "")
                (goto-char (point-at-bol))
                (if (looking-at "\\(**+\\) ")
                    (replace-match "\\1 [%] ")))
              ;; (org-show-entry)
              ;; (org-forward-sentence)
              ;; (newline)
              ;; (goto-char (point-at-bol))
              ;; (call-interactively 'org-insert-todo-subheading)
              ;; (call-interactively 'org-do-demote)
              (goto-char (point-at-eol)))
            )
  :bind (:map org-mode-map
         ("S-<return>" . org-insert-heading-after-current)
         ("S-M-<return>" . org-insert-todo-heading-respect-content)
         ("S-M-<up>" . org-move-subtree-up)
         ("S-M-<down>" . org-move-subtree-down)
         ("C-c C-e" . gusev/org-todo-convert-to-project)
         ("C-<return>" . org-todo)
         ("C-M-<return>" . org-archive-subtree-default)
         ("C-b" . org-switchb)
         ("C-S-<left>" . nil)
         ("C-S-<right>" . nil)
         ("S-<left>" . nil)
         ("S-<right>" . nil)
         ("C-S-<up>" . nil)
         ("C-S-<down>" . nil)
         ("S-<up>" . nil)
         ("S-<down>" . nil)
         :map org-agenda-mode-map
         ("C-<return>" . org-agenda-todo))
  :custom (org-provide-todo-statistics 'all-headlines))

(use-package! org-agenda
  :bind* (:map org-agenda-mode-map
          ("z" . org-agenda-undo)))

(global-set-key (kbd "M-<down>") 'other-window)
(global-unset-key (kbd "C-x O"))
(defun other-window-back ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "M-<up>") 'other-window-back)

(use-package! helm
  :init
  (require 'helm-projectile)
  (setq helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match    t
        helm-M-x-fuzzy-match      t)
  ;; (when (executable-find "ack-grep")
  ;;   (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
  ;;         helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
  ;; (when (executable-find "ag")
  ;;   (setq helm-grep-default-command "ag --nocolor --nogroup %p %f"
  ;;         helm-grep-default-recurse-command "ag --nocolor --nogroup %p %f"))
  :config
  (require 'subr-x)
  (defvar helm-source-emacs-process
    (helm-build-sync-source "Emacs Process"
      :init (lambda ()
              (let (tabulated-list-use-header-line)
                (list-processes--refresh)))
      :candidates (lambda () (mapcar
                              (lambda (process)
                                (concat (process-name process)
                                        " ["
                                        (string-join (process-command process) " ")
                                        "] "))
                              (process-list)))
      :persistent-action (lambda (elm)
                           (delete-process (get-process elm))
                           (helm-delete-current-selection))
      :persistent-help "Kill Process"
      :action (helm-make-actions "Kill Process"
                                 (lambda (_elm)
                                   (cl-loop for p in (helm-marked-candidates)
                                            do (delete-process (get-process p)))))))
  (setq helm-mini-default-sources
        '(helm-source-buffers-list helm-source-recentf helm-source-projectile-files-list))
  :bind (("C-e" . helm-mini)
         ("C-p" . helm-M-x)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action) ; rebind tab to run persistent action
         ("C-i" . helm-execute-persistent-action) ; make TAB works in terminal
         ("C-a" . helm-select-action) ; list actions using C-a
         ("C-z" . undo-tree-undo)
         ;; :map helm-moccur-mode-map
         ;; ("RET" . helm-moccur-mode-goto-line-ow)
         ;;:map helm-find-files-map
         ;;("C-z" . undo-tree-undo)
         ))

(use-package! helm-projectile)

(use-package! helm-files
  :config
  (unbind-key "C-<backspace>" helm-find-files-map)
  (unbind-key "C-<backspace>" helm-read-file-map)
  :bind (:map helm-find-files-map
         ("C-z" . undo-tree-undo))
  :custom (helm-ff-fuzzy-matching t))

(use-package! expand-region
  :init
  (global-set-key (kbd "C-h") 'er/expand-region)
  (global-set-key (kbd "C-S-h") (lambda () (interactive) (er/expand-region -1))))

(use-package! mwim
  :config
  (global-set-key (kbd "<home>") 'mwim-beginning-of-code-or-line))

(global-set-key (kbd "C-M-l") 'indent-region)

(global-set-key (kbd "C-s") (lambda () (interactive) (save-some-buffers +1)))

(setq search-exit-option 'edit)
;; (global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "S-<return>") 'isearch-repeat-backward)
(define-key isearch-mode-map [return] 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-v") 'isearch-yank-kill)
(define-key minibuffer-local-isearch-map (kbd "C-f") 'isearch-forward-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-r") 'isearch-backward-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "C-v") 'isearch-yank-kill)
(remove-hook 'isearch-mode-hook 'isearch-yank-kill)
(global-set-key (kbd "C-r") 'anzu-query-replace-regexp)
(global-anzu-mode +1)

(global-set-key (kbd "C-f") '+default/search-buffer)
(global-set-key (kbd "C-S-f") '+default/search-project)

(global-set-key (kbd "C-M-<down>") 'next-error)
(global-set-key (kbd "C-M-<up>") (lambda () (interactive) (next-error -1)))

(setq select-enable-clipboard t)
(setq select-active-regions nil)

(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "C-/") 'comment-dwim)))
(add-hook 'conf-mode-hook (lambda () (local-set-key (kbd "C-/") 'comment-dwim)))

(use-package! ahk-mode
  :bind (:map ahk-mode-map
         ("C-/" . comment-dwim)))

(use-package! undo-tree
  :bind (:map undo-tree-map
         ("C-/" . nil)
         ("C-z" . undo-tree-undo)
         ("C-S-z" . undo-tree-redo)))
(global-undo-tree-mode +1)

(global-set-key [f6] 'toggle-truncate-lines)
(use-package! winner
  :init
  (global-set-key [f2] 'winner-undo)
  (global-set-key [f3] 'winner-redo))

(global-set-key (kbd "C-j") '(lambda () (interactive) (next-line) (join-line)))
(global-set-key (kbd "C-S-j") '(lambda () (interactive) (next-line) (join-line)))
(global-set-key (kbd "C-d") 'spacemacs/duplicate-line-or-region)

(global-set-key (kbd "C-w") 'kill-this-buffer)
;; (global-set-key (kbd "C-m") 'recenter-top-bottom)
(global-set-key (kbd "C-a") 'mark-whole-buffer)

(use-package! comint
  :bind (:map comint-mode-map
         ("C-d" . comint-delchar-or-maybe-eof)
         ("C-c" . nil)))

(use-package! python-mode
  :bind (:map python-mode-map
         ("<tab>" . python-indent-shift-right)
         ("<backtab>" . python-indent-shift-left)))

(use-package! popup
  :init
  (plist-put +popup-defaults :modeline t)
  (set-popup-rule! "\\*compilation" :side 'bottom :size 0.5 :modeline t))

(global-auto-revert-mode +1)

(setq-default cursor-type '(bar . 3))

(use-package! json-mode
  :init (setq js-indent-level 2))

(use-package! rst-mode
  :bind (:map rst-mode-map
         ("<tab>" . indent-rigidly-right)
         ("<backtab>" . indent-rigidly-left)))

(use-package lsp-mode
  :bind (:map lsp-mode-map
         ("M-." . lsp-find-definition)
         ("M-<RET>" . lsp-execute-code-action)
         ("C-q" . lsp-describe-thing-at-point)
         ("M-7" . lsp-ui-peek-find-references))
  :config
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'"))

(use-package! dap-mode
  :bind (:map dap-mode-map
         ("<f8>" . dap-breakpoint-toggle)
         ("C-<f8>" . dap-breakpoint-condition)
         ("<f9>" . dap-debug)
         ("C-9" . dap-debug)
         ("M-r" . dap-debug-last)
         ("<f7>" . dap-ui-expressions)
         ("C-S-<f8>" . dap-ui-breakpoints)
         ("<f10>" . dap-go-to-output-buffer))
  :custom
  (dap-auto-configure-features '())
  (dap-auto-show-output nil)
  (dap-output-window-max-height 10)
  (dap-output-window-max-height 20)
  :init
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

(use-package! git-gutter
  :init
  (global-set-key (kbd "C-M-z") 'git-gutter:revert-hunk)
  (global-set-key (kbd "C-<next>") 'git-gutter:next-hunk)
  (global-set-key (kbd "C-<prior>") 'git-gutter:previous-hunk))

(use-package! treemacs
  :bind (:map treemacs-mode-map
              ("M-<up>" . other-window-back)
              ("M-<down>" . other-window)))

(defun projectile-test-rerun ()
  (interactive)
  (let ((compilation-read-command nil))
    (call-interactively 'projectile-test-project)))

(use-package! projectile
  :bind (:map global-map
              ("C-S-t" . projectile-toggle-between-implementation-and-test)
              ("C-8" . projectile-run-async-shell-command-in-root)
              ("C-0" . project-compile)
              ("M-r" . recompile)
              ("M-9" . magit-status)))

(use-package! anaconda-mode
  :bind (:map anaconda-mode-map
              ("M-r" . recompile)))
(use-package! compile
  :ensure nil
  :init
  ;; Add NodeJS error format
  (setq compilation-error-regexp-alist-alist
        (cons '(node "^[  ]+at \\(?:[^\(\n]+ \(\\)?\\([@a-zA-Z\.0-9_/-]+\\):\\([0-9]+\\):\\([0-9]+\\)\)?$"
                1 ;; file
                2 ;; line
                3 ;; column
                )
              compilation-error-regexp-alist-alist))
  (setq compilation-error-regexp-alist
        (cons 'node compilation-error-regexp-alist)))


(use-package! vterm
  :bind* (:map vterm-mode-map
               ("C-z" . vterm-undo)
               ("C-v" . vterm-yank)
               ("C-<backspace>" . vterm-send-meta-backspace))
  :custom (vterm-min-window-width 200)
          (vterm-shell "/bin/bash -l")
  :init
  (add-hook 'vterm-mode-hook 'compilation-shell-minor-mode)
  )

(use-package! tide
  :bind (:map tide-mode-map
         ("C-q" . tide-documentation-at-point)))

(use-package! better-jumper
  :bind (("M-[" . better-jumper-jump-backward)
         ("M-]" . better-jumper-jump-forward))
  :config
  (with-eval-after-load 'isearch
    (defadvice isearch-forward (before better-jumper activate)
      (when (bound-and-true-p better-jumper-local-mode)
        (better-jumper-set-jump))))

  (defadvice beginning-of-buffer (before better-jumper activate)
      (when (bound-and-true-p better-jumper-local-mode)
        (better-jumper-set-jump)))

  (defadvice +default/search-buffer (before better-jumper activate)
      (when (bound-and-true-p better-jumper-local-mode)
        (better-jumper-set-jump)))

  (defadvice end-of-buffer (before better-jumper activate)
      (when (bound-and-true-p better-jumper-local-mode)
        (better-jumper-set-jump))))

(use-package! shell
  :ensure nil
  :init (setq shell-prompt-pattern "^[^#$%>\n]*[#$%>➜] *"))

;; (use-package! ob-core
;;   :ensure nil
;;   :init
;;   (require 'cl)
;;   (defun org-redisplay-ansi-source-blocks ()
;;     "Refresh the display of ANSI text source blocks."
;;     (interactive)
;;     (org-element-map (org-element-parse-buffer) 'src-block
;;       (lambda (src)
;;         (when (equalp "ansi" (org-element-property :language src))
;;           (let ((begin (org-element-property :begin src))
;;                 (end (org-element-property :end src)))
;;             (ansi-color-apply-on-region begin end))))))

;;   (add-to-list 'org-babel-after-execute-hook #'org-redisplay-ansi-source-blocks)

;;   (org-babel-do-load-languages 'org-babel-load-languages '((shell . t))))

(after! git-gutter-fringe
  (fringe-mode 12))

(setq w32-pass-lwindow-to-system nil)
(setq w32-pass-rwindow-to-system nil)

;; (use-package! ispell
;;   :init (setq ispell-dictionary "english"))

(use-package! spell-fu
  :bind ("M-$" . +spell/add-word))

(use-package! jest-test-mode
  :ensure t
  :commands jest-test-mode
  :hook (typescript-mode js-mode typescript-tsx-mode))

(use-package! multi-cursors
  :bind (("M-j" . mc/mark-next-like-this)
         ("M-C-j" . mc/mark-all-like-this)
         :map mc/keymap
         ("<return>" . nil)
         ("C-v" . nil)
         ("M-v" . nil)
         ("M-<down>" . mc/cycle-forward)
         ("M-<up>" . mc/cycle-backward)))

(use-package! jenkinsfile-mode)

(use-package! ein-notebook
  :bind (:map ein:notebook-mode-map
         ("C-<return>" . ein:worksheet-execute-cell-km)
         ("M-<up>" . nil)
         ("M-<down>" . nil)))

(global-subword-mode +1)
(blink-cursor-mode +1)

(global-set-key (kbd "C-i") 'delete-other-windows)

;; We don't need cua-mode!
(after! doom-keybinds
  (keyboard-translate ?\C-d ?\C-c)
  (keyboard-translate ?\C-t ?\C-x)
  (keyboard-translate ?\C-x 'control-x)
  (keyboard-translate ?\C-c 'control-c)
  (keyboard-translate ?\C-v 'control-v)
  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
  (global-set-key [control-x] 'kill-region)
  (global-set-key [control-c] 'kill-ring-save)
  (global-set-key [control-v] 'yank)
  (global-set-key (kbd "C-z") 'undo)
  (global-unset-key (kbd "C-<return>"))
  )

(use-package! helm-icons
  :config
  ;; Workaround https://github.com/yyoncho/helm-icons/issues/16 (Bringing up
  ;; helm-buffers-list breaks when using all-the-icons provider.)

  (defun dotfiles--helm-icons--get-icon (file)
    "Get icon for FILE."
    (cond ((eq helm-icons-provider 'all-the-icons)
           (require 'all-the-icons)
           (concat
            (or (cond ((not (stringp file)) (all-the-icons-octicon "gear"))
                      ((or
                        (member (f-base file) '("." ".."))
                        (f-dir? file))
                       (all-the-icons-octicon "file-directory")))
                (all-the-icons-icon-for-file file))
            " "))
          ((eq helm-icons-provider 'treemacs)
           (helm-icons--treemacs-icon file))))

  (advice-add #'helm-icons--get-icon :override #'dotfiles--helm-icons--get-icon)

  (defun dotfiles--helm-icons--get-icon-for-mode (mode)
    "Get icon for MODE.
First it will use the customized helm-icons-mode->icon to resolve the icon,
otherwise it tries to use the provider."
    (or (-some->> (assoc major-mode helm-icons-mode->icon)
          (cl-rest)
          helm-icons--get-icon)
        (cond ((eq helm-icons-provider 'all-the-icons)
               (-let ((icon (all-the-icons-icon-for-mode mode)))
                 (when (stringp icon) (concat icon " "))))
              (t nil))))


  (defun dotfiles--helm-icons-buffers-add-icon (candidates _source)
    "Add icon to buffers source.
CANDIDATES is the list of candidates."
    (-map (-lambda ((display . buffer))
            (cons (concat
                   (with-current-buffer buffer
                     (or (dotfiles--helm-icons--get-icon-for-mode major-mode)
                         (-some->> (buffer-file-name)
                           helm-icons--get-icon)
                         (helm-icons--get-icon 'fallback)))
                   display)
                  buffer))
          candidates))

  (advice-add #'helm-icons-buffers-add-icon :override
              #'dotfiles--helm-icons-buffers-add-icon))

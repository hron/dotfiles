;;; packages.el --- gusev layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Aleksei Gusev <aleksei@thor>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `gusev-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `gusev/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `gusev/pre-init-PACKAGE' and/or
;;   `gusev/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst gusev-packages
  '(
    org
    (org-caldav :requires org)
    oauth2
    nvm
    jest-test-mode
   )
  "The list of Lisp packages required by the gusev layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun gusev/init-org ()
  (use-package org
    :init ((lambda ()
             (org/init-org)
             (add-hook 'org-capture-after-finalize-hook 'delete-frame)
             (add-hook 'org-mode-hook '(lambda ()
                                         (toggle-truncate-lines -1)
                                         (toggle-word-wrap +1)))
             (add-hook 'after-save-hook '(lambda ()
                                           (when (eq major-mode 'org-mode)
                                             (org-caldav-sync)
                                             (org-caldav-sync))))
             (setq org-tag-alist '(("outside" . ?o)
                                   ("read" . ?r)
                                   ("games" . ?g)
                                   ("shop" . ?s)
                                   ("office" . ?e)
                                   ("thor-linux" . ?t)
                                   ("thor-windows" . ?w)
                                   ("thinkpad" . ?x)
                                   (:startgroup)
                                   ("Elena" . ?E)
                                   (:endgroup)
                                   )
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
              )))))

(defun gusev/init-org-caldav ()
  (use-package org-caldav
    :config ((lambda ()
               (setq org-caldav-url 'google
                     org-caldav-calendar-id "6oqbribi3hku4n81i2ach9b3qo@group.calendar.google.com"
                     org-caldav-inbox "~/org/from-google-calendar.org"
                     org-caldav-files '("~/org/tasks.org"
                                        "~/org/tickler.org"
                                        "~/org/f-secure.org"
                                        "~/org/inbox.org")
                     org-caldav-save-directory "~/org/.org-caldav"
                     org-icalendar-timezone "Europe/Helsinki"
                     org-icalendar-alarm-time 10
                     org-caldav-show-sync-results 'nil
                     org-caldav-debug-level 0
                     org-caldav-sync-direction 'org->cal
                     plstore-cache-passphrase-for-symmetric-encryption t)
               ))))

(defun gusev/init-oauth2 ()
  (use-package oauth2
    :config ((lambda ()
               (setq org-caldav-oauth2-client-id "712874160068-fbgq4lk2k58hct939q5vo7g2e4o9icvu.apps.googleusercontent.com"
                     org-caldav-oauth2-client-secret "hJDHEHjaXGbNd7k90Kizk6Wy")))))

(defun gusev/init-nvm ()
  (use-package nvm
    :ensure t
    :hook (js2-mode . nvm-use-for-buffer)))

(defun gusev/init-jest-test-mode ()
  (use-package jest
    :defer t
    :commands jest-test-mode
    :hook ((js2-mode . jest-test-mode)
           (typescript-mode . jest-test-mode)
           (typescript-tsx-mode . jest-test-mode))))

;;; packages.el ends here

; LocalWords:  F-Secure

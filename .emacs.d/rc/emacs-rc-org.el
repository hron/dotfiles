;;; emacs-rc-org.el --- Org-mode customization.

;; Copyright (C) 2009  Aleksei Gusev

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-hide-leading-stars t)

(add-hook 'message-mode-hook 'turn-on-orgstruct)
(add-hook 'message-mode-hook 'turn-on-orgtbl)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; You can insert and follow links that have Org syntax not only in Org, but in
;; any Emacs buffer. For this, you should create two global commands, like this
;; (please select suitable global keys yourself):
(global-set-key "\C-cL" 'org-insert-link-global)
(global-set-key "\C-cO" 'org-open-at-point-global)

;; The most basic logging is to keep track of _when_ a certain TODO item
;; was finished.  This is achieved with(1).
;; 
;; [[info:org:Closing%20items][info:org:Closing items]]
(setq org-log-done 'time)

;; [[info:org:Setting%20up%20Remember][info:org:Setting up Remember]]
(org-remember-insinuate)
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cR" 'org-remember)

(provide 'emacs-rc-org)
;;; emacs-rc-org.el ends here

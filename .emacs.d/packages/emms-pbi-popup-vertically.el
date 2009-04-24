;;;emms-pbi-popup-vertically.el --- Popup EMMS playlist vertically

;; Copyright (C) 2005  Aleksei Gusev <aleksei.gusev@tut.by>

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
;; Created: 26 Aug 2005
;; Version: $Id$
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Based on emms-pbi-popup.el by Ulrik Jensen <terryp@daimi.au.dk>.

;;; Code:

(require 'emms-pbi)

(defvar emms-pbi-popup-vertically-version "0.1 $Revision$"
  "EMMS pbi popup version string.")
;; $Id$

(defgroup emms-pbi-popup-vertically nil
  "*Module for popping up the playlist in a keystroke."
  :group 'emms-pbi
  :prefix "emms-pbi-popup-vertically-")

(defcustom emms-pbi-popup-vertically-default-height (+ (or emms-pbi-playlist-entry-max-length 36) 4)
  "*The default height of the window to popup the playlist in.

This defaults to `emms-pbi-playlist-entry-max-length' + 4, or 40 if
`emms-pbi-playlist-entry-max-length' is nil."
  :group 'emms-pbi-popup-vertically
  :type 'number)

(defcustom emms-pbi-popup-vertically-default-side-up nil
  "*Boolean determining whether to popup in the down-side as a
default. If nil, the popup will appear in the up side."
  :type 'boolean
  :group 'emms-pbi-popup-vertically)

(defvar emms-pbi-popup-vertically-old-conf nil
  "The window-configuration when popping up the playlist.")

(defun emms-pbi-popup-vertically-forget-conf ()
  "Forget the previously saved configuration, and make the changes
final."
  (setq emms-pbi-popup-vertically-old-conf nil)
  ;; Remove the special bindings
  (emms-pbi-popup-vertically-revert)
  ;; Remove this function again, it will get addded when a new
  ;; configuration is saved anyway
  (remove-hook 'window-configuration-change-hook 'emms-pbi-popup-vertically-forget-conf))

(defun emms-pbi-popup-vertically-revert ()
  "Revert to the window-configuration from before if there is one,
otherwise just remove the special bindings from the playlist."
  (interactive)
   (remove-hook 'emms-pbi-manually-change-song-hook 'emms-pbi-popup-vertically-revert)
  (let ((playlistbuffer (get-buffer emms-pbi-playlist-buffer-name)))
    (when playlistbuffer
      (save-excursion
	(set-buffer playlistbuffer)
	(local-unset-key (kbd "q"))
	(local-unset-key (kbd "TAB")))))
  (when emms-pbi-popup-vertically-old-conf
    (set-window-configuration emms-pbi-popup-vertically-old-conf)))

;; Entry-point
(defun emms-pbi-popup-vertically-playlist (&optional popup-up popup-height )
  "Pops up the playlist temporarily, for selecting a new song.

If POPUP-UP is non-nil, the window will appear in the up side of
the current window, otherwise it will appear in the down side. 

POPUP-HEIGHT is the height of the new frame, defaulting to
`emms-pbi-popup-vertically-default-width'."
  (interactive)
  (setq popup-height (or popup-height emms-pbi-popup-vertically-default-height)
	popup-up (or popup-up emms-pbi-popup-vertically-default-side-up))
  ;; Split the current screen, and make the playlist popup
  (let ((new-window-height (- (window-height) popup-height)))
    (if (not (> new-window-height 0))
	;; consider just opening the playlist here instead of arguing
	;; semantics with the user?
	(error "Current window not wide enough to popup playlist!")
      ;; Negative value to popup in the up side
      (when popup-up
	(setq new-window-height (- new-window-height)))
      ;; Make sure EMMS is actually playing before continuing
      (if (or (not (emms-playlist-get-playlist)) (= (length (emms-playlist-get-playlist)) 0))
	  ;; we haven't got a playlist, exit.
	  (error "Can't popup playlist-buffer until a playlist has been loaded!")
	;; Save the current window-configuration
	(setq emms-pbi-popup-vertically-old-conf (current-window-configuration))
	;; Split and select the playlist
	(let ((buffer-on-the-down
	       (split-window-vertically new-window-height)))
	  (unless popup-up
	    (select-window buffer-on-the-down)))
	(unless (get-buffer emms-pbi-playlist-buffer-name)
	  ;; No playlist-buffer yet, create it.
	  (emms-pbi 1))     
	(switch-to-buffer emms-pbi-playlist-buffer-name t)
	;; Now, modify the playlist functionality to revert to the
      ;; window-configuration from before when a song is selected
	(add-hook 'emms-pbi-manually-change-song-hook 'emms-pbi-popup-vertically-revert)
	(local-set-key (kbd "TAB") 'emms-pbi-popup-vertically-revert)
	(local-set-key (kbd "q") 'delete-window)
	(local-set-key (kbd "<f3>") 'delete-window)
	;; Also, forget about the whole thing if the user does something
	;; to the window-configuration
	(add-hook 'window-configuration-change-hook 'emms-pbi-popup-vertically-forget-conf)))))

(provide 'emms-pbi-popup-vertically)

;;; emms-pbi-popup-vertically.el ends here

;;;emacs-rc-emms.el --- emms customization.

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

;; 

;;; Code:

(require 'emms)
(require 'emms-player-simple)
(require 'emms-source-file)
(require 'emms-pbi-popup)
(require 'emms-pbi-popup-vertically)

(define-emms-simple-player play "\\.wav$" "play")

;; (define-emms-player "emms-player-mpd"
;;   :start 'emms-player-mpd-start
;;   :stop 'emms-player-mpd-stop
;;   :playable 'emms-player-mpd-playable-p
;;   :regex "[Oo][Gg][Gg]\\|[Mm][Pp]3")

;; (defun emms-player-mpd-start ()
  
  
(setq emms-player-list '(emms-player-mpg321
			 emms-player-ogg123
			 emms-player-mplayer)
      emms-show-format "NP: %s"
      emms-pbi-load-info-async t
      emms-track-description-function 'fc-emms-track-description
;;       emms-pbi-playlist-entry-max-length 37
      emms-pbi-popup-vertically-default-height 15
      emms-playlist-shuffle-function 'identity
      emms-play-all-preparation-function 'emms-play-all-shuffle
      emms-source-list '((emms-source-directory-tree "~/mp3/")))

(global-set-key (kbd "<f3>") 'emms-pbi-popup-vertically-playlist)

;; (keydef "C-c m w" emms-show)
;; (global-set-key [(control ?c) ?m ?w] 'emms-show)
;; (global-set-key [(control ?c) ?m ?n] 'emms-next)
;; (global-set-key [(control ?c) ?m ?p] 'emms-previous)
;; (global-set-key [(control ?c) ?m ?s] 'emms-stop)
;; (global-set-key [(control ?c) ?m ?i] 'fc-emms-insert)

(defun fc-emms-insert ()
  "Insert a Playing MPEG stream from ... string."
  (interactive)
  (let ((emms-show-format "Playing MPEG stream from %s ..."))
    (emms-show 'insert)))

(defun fc-emms-track-description (track)
  "Return a nice description of TRACK."
  (let ((desc (emms-track-description track)))
    (if (string-match "^/home/aleksei/mp3/\\(.*\\)" desc)
	(match-string 1 desc)
      desc)))

;;; emacs-rc-emms.el ends here

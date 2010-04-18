;;; emacs-rc-emms.el --- emms customization

;; Copyright (C) 2009  Aleksei Gusev

;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Keywords: multimedia

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

(require 'emms-setup)
(emms-all)

(require 'emms-browser)
(require 'emms-tag-editor)

(require 'emms-player-mpd)
(setq emms-player-mpd-server-name "localhost"
      emms-player-mpd-server-port "6600")

(setq emms-player-mpd-music-directory "~/Музыка")

(add-to-list 'emms-info-functions 'emms-info-mpd)
(add-to-list 'emms-player-list 'emms-player-mpd)

(emms-player-mpd-connect)

(require 'emms-playing-time)
(emms-playing-time 1)
(emms-playing-time-disable-display)

(emms-mode-line-disable)

(let ((emms-lastfm-auth (expand-file-name "~/.emacs.d/.emms-lastfm-auth")))
  (when (file-exists-p emms-lastfm-auth)
    (require 'emms-lastfm)
    (load emms-lastfm-auth)
    (emms-lastfm-enable)
    ))

(add-hook 'emms-browser-show-display-hook
	  '(lambda ()
	     (local-set-key (kbd "n") 'next-line)
	     (local-set-key (kbd "j") 'next-line)
	     (local-set-key (kbd "p") 'previous-line)
	     (local-set-key (kbd "k") 'previous-line)))


(provide 'emacs-rc-emms)
;;; emacs-rc-emms.el ends here

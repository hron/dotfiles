;;; emacs-rc-calendar.el --- emacs calendar customization

;; Copyright (C) 2004, 2005  Free Software Foundation, Inc.

;; Author: Aleksei Gusev <aleksei.gusev@tut.by>
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
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; 

;;; Code:

;; *Name of the file in which one's personal diary of dates is kept.
(setq diary-file "~/var/lib/emacs/diary")

;; By default, weeks begin on Sunday.  To make them begin on Monday
;; instead, set the variable `calendar-week-start-day' to 1.
(setq calendar-week-start-day 1)

;;    Because the times of sunrise and sunset depend on the location on
;; earth, you need to tell Emacs your latitude, longitude, and location
;; name before using these commands.  Here is an example of what to set:
(setq calendar-latitude 53.9
      calendar-longitude 27.5
      calendar-location-name "Minsk, BY")

(setq calendar-time-display-form
			'(24-hours ":" minutes
								 (if time-zone " (") time-zone (if time-zone ")")))


(require 'timeclock)

(define-key ctl-x-map "ti" 'timeclock-in)
(define-key ctl-x-map "to" 'timeclock-out)
(define-key ctl-x-map "tc" 'timeclock-change)
(define-key ctl-x-map "tr" 'timeclock-reread-log)
(define-key ctl-x-map "tu" 'timeclock-update-modeline)
(define-key ctl-x-map "tw" 'timeclock-when-to-leave-string)

;;; emacs-rc-calendar.el ends here

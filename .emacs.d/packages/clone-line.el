;; From: Kevin Cutts <Kevin.Cutts@motorola.com>
;; Subject: Re: Copy line function help
;; Newsgroups: comp.emacs.xemacs
;; Date: Tue Aug 20 19:49:32 2002 +0400

;; To copy a line I've always used the following little lisp code:
(defun clone-line ()
  "Insert a duplicate of the current line below this line."
  (interactive)
  (save-excursion
    (let ((beg (progn (beginning-of-line) (point)))
		  (end (progn (end-of-line) (point))))
      (insert "\n")
      (insert-buffer-substring (current-buffer) beg end))))

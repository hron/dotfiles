(eval-after-load "w3"
  '(progn
     (fset 'w3-fetch-orig (symbol-function 'w3-fetch))
     (defun w3-fetch (&optional url target)
       (interactive (list (w3-read-url-with-default)))
       (if (eq major-mode 'gnus-article-mode)
	   (browse-url url)
	 (w3-fetch-orig url target)))))

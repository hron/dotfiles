;;; emacs-rc-mule.el ---

;; Copyright (C) 2003, 2007 Alex Ott
;;
;; Author: ott@jet.msk.su
;; Version: $Id: emacs-rc-mule.el,v 0.0 2003/11/20 07:58:49 ott Exp $
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defun reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

(reverse-input-method "cyrillic-jcuken")

(provide 'emacs-rc-mule)

;;; emacs-rc-mule.el ends here

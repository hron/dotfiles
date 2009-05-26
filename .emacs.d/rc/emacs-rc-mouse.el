;;; emacs-rc-mouse.el --- mouse

;; Effects of the different modes:
;;  * banish: Move the mouse to the upper-right corner on any keypress.
;;  * exile: Move the mouse to the corner only if the cursor gets too close,
;;      and allow it to return once the cursor is out of the way.
;;  * jump: If the cursor gets too close to the mouse, displace the mouse
;;      a random distance & direction.
;;  * animate: As `jump', but shows steps along the way for illusion of motion.
;;  * cat-and-mouse: Same as `animate'.
;;  * proteus: As `animate', but changes the shape of the mouse pointer too.
;; (mouse-avoidance-mode 'exile)

;; emacs-rc-mouse.el
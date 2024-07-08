;;; ../src/dotfiles/.doom.d/configs/doom-modeline.el -*- lexical-binding: t; -*-

(use-package! doom-modeline
  :config
  ;; Remove `compilation' segment from all modelines
  (doom-modeline-def-modeline 'main
    '(bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
    '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs time))

  (doom-modeline-def-modeline 'special
    '(bar window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
    '(objed-state misc-info battery irc-buffers debug minor-modes input-method indent-info buffer-encoding major-mode process time))

  (doom-modeline-def-modeline 'project
    '(bar window-number modals buffer-default-directory remote-host buffer-position)
    '(misc-info battery irc mu4e gnus github debug minor-modes input-method major-mode process time))

  (doom-modeline-def-modeline 'dashboard
    '(bar window-number buffer-default-directory-simple remote-host)
    '(misc-info battery irc mu4e gnus github debug minor-modes input-method major-mode process time))

  (doom-modeline-def-modeline 'vcs
    '(bar window-number modals matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info battery irc mu4e gnus github debug minor-modes buffer-encoding major-mode process time))

  (doom-modeline-def-modeline 'package
    '(bar window-number package)
    '(misc-info major-mode process time))

  (doom-modeline-def-modeline 'info
    '(bar window-number buffer-info info-nodes buffer-position parrot selection-info)
    '(misc-info buffer-encoding major-mode time))

  (doom-modeline-def-modeline 'media
    '(bar window-number buffer-size buffer-info)
    '(misc-info media-info major-mode process vcs time))

  (doom-modeline-def-modeline 'message
    '(bar window-number modals matches buffer-info-simple buffer-position word-count parrot selection-info)
    '(objed-state misc-info battery debug minor-modes input-method indent-info buffer-encoding major-mode time))

  (doom-modeline-def-modeline 'pdf
    '(bar window-number matches buffer-info pdf-pages)
    '( misc-info major-mode process vcs time))

  (doom-modeline-def-modeline 'org-src
    '(bar window-number modals matches buffer-info-simple buffer-position word-count parrot selection-info)
    '(objed-state misc-info debug lsp minor-modes input-method indent-info buffer-encoding major-mode process time))

  :custom
  (doom-modeline-lsp nil))

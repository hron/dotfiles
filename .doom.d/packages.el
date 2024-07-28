;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

                                        ;(package! smartparens :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)

(package! jest-test-mode :pin "3126c5c")

(package! mocha
  :recipe (:host github :repo "hron/mocha.el" :branch "tree-sitter"))

(package! solaire-mode :disable t)

(package! git-link)

(package! dpkg-dev-el)

(package! string-inflection :pin "50ad54970b3cc79b6b83979bde9889ad9a9e1a9c")

(package! separedit :pin "91a41ff")

(package! rg :pin "14d4c6a754d127c5cacd58fb66bb0992faff68e4")

(package! crux :pin "f8789f67a9d2e1eb31a0e4531aec9bb6d6ec1282")

(package! cfn-mode :pin "4cf56affe3035fda364109836e26499431095185")

;; (package! vundo :pin "12862c673d274adab2b9232a281f64898016c3e4")

(package! kbd-mode
  :recipe (:host github
           :repo "kmonad/kbd-mode"))

(package! auto-dark)

(package! gptel
  :recipe (:host github :repo "hron/gptel")
  :pin "730d19212e1e1a0c85f4c91a3aa8f02af29ed377")

;; Activate me after upgrade to Emacs 30
;; (package! indent-bars
;;   :recipe (:host github :repo "jdtsmith/indent-bars")
;;   :pin "756cfb0f55a6d0e3eccc6e12211aac922aa71a49")

(package! treesit-auto)

(package! scroll-on-jump)

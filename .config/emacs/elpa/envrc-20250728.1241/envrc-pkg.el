;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "envrc" "20250728.1241"
  "Support for `direnv' that operates buffer-locally."
  '((emacs      "27.1")
    (inheritenv "0.1")
    (seq        "2.24"))
  :url "https://github.com/purcell/envrc"
  :commit "189bafea47c3110ec897c1c5bc1558fbcc407b85"
  :revdesc "189bafea47c3"
  :keywords '("processes" "tools")
  :authors '(("Steve Purcell" . "steve@sanityinc.com"))
  :maintainers '(("Steve Purcell" . "steve@sanityinc.com")))

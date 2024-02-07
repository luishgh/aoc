(use-modules
 (guix gexp)
 (guix packages)
 (guix build-system go))

(define %source-dir (dirname (current-filename)))

(define yule
  (package
    (name "yule")
    (version "0.0.1-dev")
    (source (local-file %source-dir #:recursive? #t))
    (build-system go-build-system)
    (arguments
     '(#:install-source? #f
       #:import-path "aoc/yule"
       #:unpack-path "aoc/yule"))
    (home-page "")
    (synopsis "My personal AOC helper")
    (description "")
    (license #f)))

yule

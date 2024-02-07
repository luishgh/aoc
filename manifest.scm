(define yule 
  (load "yule/guix.scm"))

(concatenate-manifests
 (list
  (packages->manifest
   (list yule))
  (specifications->manifest
   '( ;; 2015
     "ocaml"

     ;; 2022
     "gcc-toolchain"

     ;; yule
     "go"
     "gopls"))))

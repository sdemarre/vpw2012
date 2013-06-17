;;;; vpw2012.asd

(asdf:defsystem #:vpw2012
  :serial t
  :description "Describe vpw2012 here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (:iterate :split-sequence :let-plus)
  :components ((:file "package")
               (:file "vpw2012")
	       (:file "read-utils")
	       (:file "rbt-solver")
	       (:file "dominos")))


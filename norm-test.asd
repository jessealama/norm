(asdf:defsystem #:norm-test
  :description "Testing norm (the system for normalizing natural deduction proofs)"
  :version "0.1"
  :license ""
  :author "Jesse Alama <jesse.alama@gmail.com>"
  :maintainer "Jesse Alama <jesse.alama@gmail.com>"
  :depends-on (:norm :fiveam)
  :components ((:module "test"
			:serial t
			:components ((:file "packages")
				     (:file "coverage")))))

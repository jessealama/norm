
(in-package :norm-test)

(test eq-atoms
    (is (eq (make-instance 'atomic-formula :predicate 'p)
	    (make-instance 'atomic-formula :predicate 'p))))

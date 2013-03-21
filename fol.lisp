(in-package :norm)

(defclass term ()
  nil)

(defclass formula ()
  nil)

(defclass atomic-formula (formula)
  ((predicate
    :type symbol
    :initform (error "To make an atomic formula, a predicate (symbol) is required.")
    :initarg :predicate
    :reader predicate)
   (arguments
    :type list
    :initform nil
    :initarg :arguments
    :reader arguments)))

(defvar *formula-table* (make-hash-table :test #'eql))

(defmethod make-instance :before ((class (eql 'atomic-formula))
				  &rest initargs &key &allow-other-keys)
  (error "haha!"))

(defmethod make-instance :around ((class (eql 'atomic-formula))
				  &rest initargs &key &allow-other-keys)
  (let ((predicate-tail (member :predicate initargs)))
    (if predicate-tail
	(if (rest predicate-tail)
	    (let ((predicate (first predicate-tail)))
	      (multiple-value-bind (already-created present-p)
		  (gethash predicate *formula-table*)
		(if present-p
		    already-created
		    (let ((instance (call-next-method)))
		      (setf (gethash predicate *formula-table*) instance)))))
	    (error "Invalid call to MAKE-INSTANCE for ATOMIC-FORMULA (:predicate keyword is present, but this keyword ends the list of initialization arguments)."))
	(error "Invalid call to MAKE-INSTANCE for ATOMIC-FORMULA (mandatory :predicate keyword is missing)."))))

(defclass negation (formula)
  ((argument
    :type formula
    :reader argument
    :initform (error "To make a negation, an argument is required.")
    :initarg :argument)))

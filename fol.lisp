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

(defclass negation (formula)
  ((argument
    :type formula
    :reader argument
    :initform (error "To make a negation, an argument is required.")
    :initarg :argument)))

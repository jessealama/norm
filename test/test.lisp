
(in-package :norm-test)

(defun run-all-tests ()
  (reduce #'append (mapcar #'run (remove-if #'null (test-names))))
  ;                               ^^^^^^^^^^^^^^^^
  ;                               huh? Not sure why NIL seems to be (always) present
  )

(defun run-tests-quietly ()
  (let ((s (make-broadcast-stream)))
    (let ((*standard-output* s))
      (prog1
	  (run-all-tests)
	(close s)))))

(defun test-and-exit-cleanly ()
  "Run all tests.  Exit the Lisp image cleanly (even if some tests didn't pass)."
  (let ((results (run-tests-quietly)))
    (explain! results)
    #+ccl
    (ccl:quit 0)
    #+sbcl
    (sb-ext:exit 0)
    #-(or ccl sbcl)
    (error "We know how to quit only for CCL and SBCL.")))

(defun error-result-p (result)
  (typep result 'fiveam::test-failure))

(defun passed-result-p (result)
  (typep result 'fiveam::test-passed))

(defun skipped-result-p (result)
  (typep result 'fiveam::test-skipped))

(defun error-tests (results-list)
  (remove-if-not #'error-result-p results-list))

(defun passed-tests (results-list)
  (remove-if-not #'passed-result-p results-list))

(defun skipped-tests (results-list)
  (remove-if-not #'skipped-result-p results-list))

(defun unknown-tests (results-list)
  (remove-if #'(lambda (x)
		 (or (error-result-p x)
		     (passed-result-p x)
		     (skipped-result-p x)))
	     results-list))

(defun test-and-exit-strictly ()
  "Run all tests, exiting the Lisp image with exit code 1 if any test didn't pass."
  (let ((results (run-tests-quietly)))
    (let ((exit-code (if (or (error-tests results)
			     (skipped-tests results)
			     (unknown-tests results))
			 1
			 0)))
      (explain! results)
      #+ccl
      (ccl:quit exit-code)
      #+sbcl
      (sb-ext:exit exit-code)
      #-(or ccl sbcl)
      (error "We know how to quit only for CCL and SBCL."))))

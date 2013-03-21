(in-package :norm-test)

(defun external-symbols (package)
  (check-type package package)
  (loop :for s :being :the :external-symbols :of package :collect s))

(defun function-p (symbol)
  (check-type symbol symbol)
  (handler-case (symbol-function symbol)
    (undefined-function () nil)))

(defun function-covered-p (symbol)
  (member symbol (test-names) :test #'string= :key #'symbol-name))

(defun exported-function-symbols (package)
  (remove-if-not #'function-p (external-symbols package)))

(test all-exported-functions-covered
  (is-false (remove-if #'function-covered-p
		       (exported-function-symbols (find-package :norm)))))

.PHONY: all test

test-asd = ../norm-test.asd
test-package = :norm-test

test: all

all: test.lisp
	@which ccl > /dev/null
	@ccl --batch --load $(test-asd) --eval "(let ((s (make-broadcast-stream))) (let ((*standard-output* s)) (handler-case (ql:quickload $(test-package)) (error () (close s) (ccl:quit 1)))) (close s))" --load test.lisp --eval "(in-package $(test-package))" --eval '(test-and-exit-cleanly)'

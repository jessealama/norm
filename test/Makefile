.PHONY: all test

cl-tptp-test-asd = ../cl-tptp-test.asd

test: all

all: test.lisp
	@which ccl > /dev/null
	@ccl --batch --load $(cl-tptp-test-asd) --eval "(let ((s (make-broadcast-stream))) (let ((*standard-output* s)) (handler-case (ql:quickload :cl-tptp-test) (error () (close s) (ccl:quit 1)))) (close s))" --load test.lisp --eval "(in-package :cl-tptp-test)" --eval '(test-and-exit-cleanly)'

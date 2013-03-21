.PHONY: all test

test-asd = ../norm-test.asd
test-package = :norm-test

lisp-files = $(wildcard *.lisp)
editable-files = Makefile $(lisp-files)
emacs-backups = $(addsuffix ~,$(editable-files))
ccl-fasls = $(wildcard *.dx64fsl)
plain-fasls = $(wildcard *.fasl)
fasls = $(ccl-fasls) $(plain-fasls)

clean:
ifneq ($(strip $(emacs-backups)),)
	rm -f $(emacs-backups)
endif
ifneq ($(strip $(fasls)),)
	rm -f $(fasls)
endif

test: all

all: test.lisp
	@which ccl > /dev/null
	@ccl --batch --load $(test-asd) --eval "(let ((s (make-broadcast-stream))) (let ((*standard-output* s)) (handler-case (ql:quickload $(test-package)) (error () (close s) (ccl:quit 1)))) (close s))" --load test.lisp --eval "(in-package $(test-package))" --eval '(test-and-exit-cleanly)'

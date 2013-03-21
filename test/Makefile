.PHONY: all test

test-asd = ../norm-test.asd
package = norm
package-keyword = :$(package)
test-package = norm-test
test-package-keyword = :$(test-package)

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
	@ccl --batch --eval "(let ((s (make-broadcast-stream))) (let ((*standard-output* s)) (handler-case (ql:quickload $(test-package-keyword)) (error () (close s) (ccl:quit 1)))) (close s))" --load test.lisp --eval "(in-package $(test-package-keyword))" --eval '(test-and-exit-cleanly)'

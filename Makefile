gen-html:
	emacs --batch -l ./publish.el --funcall kd/publish

gen-el:
	emacs --batch -l ./init.el -l ./publish.el --funcall kd/gen-el

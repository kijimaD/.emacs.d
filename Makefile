gen-html:
	emacs --batch -l ./publish.el --funcall kd/publish

gen-el:
	emacs --batch -l ./init.el -l ./publish.el --funcall kd/gen-el

gen-el-local:
	/usr/bin/emacs --batch -l ./init.el -l ./publish.el --funcall kd/gen-el

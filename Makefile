# just a test
install_configs:
	mkdir $$HOME/bin || true;
	for each in $$( find bin/ -mindepth 1) $$( ls -a1 | egrep -v '(Makefile|\.git|^\.\.?$$|\~$$|#)'); do \
	  [ -e $$HOME/$$each ] || ln -nfs `pwd`/$$each $$HOME/$$each; \
	done;

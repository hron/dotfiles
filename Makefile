# just a test
install_configs:
	for each in $$( ls -a1 | egrep -v '(Makefile|\.git|^\.\.?$$|\~$$)'); do \
	  ln -s `pwd`/$$each $$HOME/$$each; \
	done;
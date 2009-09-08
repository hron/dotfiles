# just a test
install_configs:
	for each in $$( ls -a1 | egrep -v '(Makefile|\.git|^\.\.?$$|\~$$|#)'); do \
	  [ -e $$HOME/$$each ] || ln -nfs `pwd`/$$each $$HOME/$$each; \
	done;
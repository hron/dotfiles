install_configs:
	for each in $$( ls -a1 | egrep -v '(Makefile|\.git|^\.\.?$$|\~$$)'); do \
	  ln -nfs `pwd`/$$each $$HOME/$$each; \
	done;
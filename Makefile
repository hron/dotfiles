install_configs:
	mkdir $$HOME/bin || true;
	for each in $$(find bin/ -mindepth 1 | egrep -v '#$$|~$$') $$( ls -a1 | egrep -v '(^clone_and_link.sh$$|^bin$$|^Makefile$$|\.git$$|\.gitignore$$|\.gitmodules|^\.\.?$$|\~$$|#$$)'); do \
          [ -e $$HOME/$$each ] || ln -nfs `pwd`/$$each $$HOME/$$each; \
	done
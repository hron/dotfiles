notification :on

Pry.plugins['stack_explorer'] && Pry.plugins['stack_explorer'].disable!
Pry.pager = false if ENV['EMACS']


# Beginning of the el4r block:
# RCtool generated this block automatically. DO NOT MODIFY this block!
### Internal variables
@stdlib_dir = "/home/gusev/.emacs.d/site-lisp/el4r/lib/el4r/emacsruby"
@site_dir = "/home/gusev/.el4r/site"
@autoload_dir = "/home/gusev/.emacs.d/site-lisp/el4r/lib/el4r/emacsruby/autoload"
@el_program_relative = "data/emacs/site-lisp/el4r.el"
@instance_program_relative = "bin/el4r-instance"
@el_program = "/home/gusev/.emacs.d/site-lisp/el4r/data/emacs/site-lisp/el4r.el"
@instance_program = "/home/gusev/.emacs.d/site-lisp/el4r/bin/el4r-instance"
@lisp_object_gc_trigger_count = 100
@lisp_object_gc_trigger_increment = 100
@ruby_gc_trigger_count = 100
@ruby_gc_trigger_increment = 100
@log_buffer = "*el4r:log*"
@output_buffer = "*el4r:output*"
@unittest_lisp_object_gc_trigger_count = 5000
@unittest_lisp_object_gc_trigger_increment = 5000
@unittest_ruby_gc_trigger_count = 5000
@unittest_ruby_gc_trigger_increment = 5000
@temp_file = "/tmp/el4r-#{ENV['USER'] || ENV['USERNAME'] || 'me'}.tmp"

### El4r bootstrap code
def __conf__
  if ENV['EL4R_ROOT']
    $: << File.join(ENV['EL4R_ROOT'], "lib")
  end
  require 'el4r/el4r-sub'
  ConfigScript.new(__FILE__)
end

def __elisp_init__
  $> << "(setq \n"
  instance_variables.map{|iv| [iv[1..-1], instance_variable_get(iv)]}.each {|k,v|  $> << "el4r-#{k.gsub(/_/,'-')} #{v.inspect}\n" if Numeric === v or String === v}
  $> << ')' << "
"
end

at_exit { __elisp_init__  if __FILE__==$0 }

### Customizable variables
### You can override these variables in User-setting area.
# directory containing EmacsRuby scripts
@home_dir = ENV['EL4R_HOME'] || File.expand_path("~/.el4r")
# startup EmacsRuby script
@init_script = "init.rb"
# EmacsRuby search path
@el4r_load_path = [ @home_dir, @site_dir, @stdlib_dir, "." ]
# End of the el4r block.
# User-setting area is below this line.

# Ruby interpreter name used by el4r
@ruby_program = "ruby"
# Emacs program name used by el4r / el4r-runtest.rb
@emacs_program = "emacs"

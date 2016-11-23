if ENV['TERM'] == 'emacs'
   Pry.config.pager = false 
   Pry.config.auto_indent = false
end
Pry.prompt = Pry::SIMPLE_PROMPT

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
  puts "no awesome_print :("
end

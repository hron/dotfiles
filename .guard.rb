require 'pry'
if ENV['INSIDE_EMACS']
  Pry.pager = false
  Pry.color = false
end


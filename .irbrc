def tramp_require(what, &block)
  loaded, require_result = false, nil

  begin
    require_result = require what
    loaded = true
  rescue Exception => ex
    warn "** Unable to require '#{what}'"
    warn "--> #{ex.class}: #{ex.message}"
  end

  yield if loaded and block_given?

  require_result
end

tramp_require('rubygems') do

  tramp_require('wirble') do
    # start wirble (with color)
    Wirble.init
    Wirble.colorize
  end

end

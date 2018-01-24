# -*- coding: utf-8 -*-

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

require 'awesome_print'
AwesomePrint.irb! if defined? AwesomePrint
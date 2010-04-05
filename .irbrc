# -*- coding: utf-8 -*-
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

def with_env(name, value)
  old = ENV[name]
  ENV[name] = value
  yield
ensure
  ENV[name] = old
end

# dirty-dirty-dirty hack.
ENV['TERM'] = 'emacs' if ENV['EMACS']

tramp_require('rubygems') do

  tramp_require('wirble') do
    # start wirble (with color)
    Wirble.init
    Wirble.colorize
  end

  # awesome_print – позволяет выводить объекты на экран в удобном формате и с
  # подсветкой.

  # ap(object, options = {})
  #
  # Default options:
  #   :miltiline => true,
  #   :plain  => false,
  #   :indent => 4,
  #   :colors => {
  #     :array      => :white,
  #     :bignum     => :blue,
  #     :class      => :yellow,
  #     :date       => :greenish,
  #     :falseclass => :red,
  #     :fixnum     => :blue,
  #     :float      => :blue,
  #     :hash       => :gray,
  #     :nilclass   => :red,
  #     :string     => :yellowish,
  #     :symbol     => :cyanish,
  #     :time       => :greenish,
  #     :trueclass  => :green
  #   }
  #
  # Supported color names:
  #   :gray, :red, :green, :yellow, :blue, :purple, :cyan, :white
  #   :black, :redish, :greenish, :yellowish, :blueish, :purpleish, :cyanish, :pale
  tramp_require 'ap'

  # looksee – позволяет посмотреть список методов объекта, разбитый по классам/модулям, из которых
  # эти методы происходят. Очень удобно при исследовании внутренностей классов и модулей фреймворка
  # при отладке или разработке плагинов.
  tramp_require 'looksee/shortcuts' do
    # purple
    Looksee.styles.merge!(:undefined => "\e[1;34m%s\e[0m")
  end
end

# Вывод лога SQL-запросов в консоль – при работе с моделями ActiveRecord все запросы к БД будут
# выводиться прямо на экран:
# enable_log  # включаем логи
# disable_log # выключаем логи
def change_log(stream)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.clear_active_connections!
  reload!
end

def show_log
  change_log(STDOUT)
  #warn "SQL log enabled. Enter 'reload!' to reload all loaded ActiveRecord classes"
end

def hide_log
  change_log(nil)
  #warn "SQL log disabled. Enter 'reload!' to reload all loaded ActiveRecord classes"
end

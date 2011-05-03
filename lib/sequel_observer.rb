#!/usr/local/bin/ruby -w
# coding: utf-8

require 'sequel_observer/filter'

unless defined? Sequel::Observer

##
# class Sequel::Observer
#
class Sequel::Observer
  # Class methods

  ##
  # == Usage:
  # Sequel::Observer.observers = :model_name_observer
  # Sequel::Observer.observers = :model_1_name_observer, :model_2_name_observer,
  #
  def self.observers=(observer_interns)
    @@observers_pool ||= Hash.new do |observers_hash, observer|
      observers_hash[observer.observing_klass_name] = observer
    end

    if observer_interns
      Array(observer_interns).each do |observer_sym|
        # Create and register observer instance
        self.register(observer_sym.to_s.classify.constantize.new)
      end
    end
  end

  def self.register(observer) # :nodoc:
    @@observers_pool[observer].observing_hooks.each do |call_back_method|
      observer.observing_klass.class_eval do
        define_method(call_back_method.intern) do
          Sequel::Observer.find_observer(self.class.to_s).send(call_back_method, self)
          super
        end
      end
    end
    nil
  end

  def self.find_observer(observing_klass_name) # :nodoc:
    @@observers_pool[observing_klass_name]
  end

  # Instance methods

  def observing_klass_name # :nodoc:
    @observing_klass_name ||= self.class.to_s[/\A(.+)Observer\z/, 1]
  end

  def observing_klass # :nodoc:
    # @observing_klass ||= ObjectSpace.class_eval(observing_klass_name)
    @observing_klass ||= observing_klass_name.classify.constantize
  end

  def hooks # :nodoc:
    @hooks ||= %W(before_validation after_validation
                  before_save       after_save
                  before_update     after_update
                  before_create     after_create
                  before_destroy    after_destroy)
  end

  def observing_hooks # :nodoc:
    filter = ::Filter.new
    filter.constraint {|x| self.hooks.include?(x)}
    self.methods.grep(/^(after|before)_/).select(&filter)
  end

end

end

__END__
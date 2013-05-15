# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

class Mestral::Hooklet; end

require 'mestral/errors'
require 'mestral/hooklet/dsl'
require 'mestral/hooklet/native'
require 'mestral/hooklet/ruby'

class Mestral::Hooklet

  def self.find(tape, name)
    hooklet = Ruby.new tape, name
    hooklet = Native.new tape, name unless hooklet.exists?
    raise Mestral::HookletNotFound.new(tape, name) unless hooklet.exists?
    hooklet
  end

  attr_reader :name
  attr_reader :path
  attr_reader :tape

  def initialize(tape, name)
    @name = name
    @tape = tape
  end

  def exists?
    File.exists? @path
  end

  def failed?
    !@passed
  end

  def passed?
    @passed
  end

  class Finished < StandardError
    def initialize(successful)
      @passed = successful
    end

    def passed?
      @passed
    end
  end

end

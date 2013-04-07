# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

class Mestral::Hooklet; end

require 'mestral/errors'
require 'mestral/hooklet/dsl'

class Mestral::Hooklet

  include DSL

  def self.find(tape, name)
    hooklet = new tape, name
    raise Mestral::HookletNotFound.new(tape, name) unless hooklet.exists?
    hooklet
  end

  attr_reader :name
  attr_reader :path
  attr_reader :tape

  def initialize(tape, name)
    @name = name
    @path = "#{File.join(tape.path, name)}.rb"
    @tape = tape
  end

  def execute
    @passed = true
    begin
      instance_eval File.read(@path)
    rescue Finished
      @passed = $!.passed?
    end
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

# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'mestral/hooklet'
require 'mestral/hooklet/dsl'

class Mestral::Hooklet::Ruby < Mestral::Hooklet

  include DSL

  def initialize(tape, name)
    super

    @path = "#{File.join(tape.path, name)}.rb"
  end

  def execute
    @passed = true
    begin
      instance_eval File.read(@path)
    rescue Finished
      @passed = $!.passed?
    end
  end

end

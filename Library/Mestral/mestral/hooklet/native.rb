# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'mestral/hooklet'

class Mestral::Hooklet::Native < Mestral::Hooklet

  def initialize(tape, name)
    super

    @path = File.join tape.path, name
  end

  def execute
    puts `#@path`
    @passed = $?.success?
  end

end

# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'mestral/hook'

class Mestral::Hook::Native < Mestral::Hook

  def execute
    `#{path}`
  end

end

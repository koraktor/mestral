# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'thor'

class Default < Thor

  default_command :spec

  desc 'spec', 'Run RSpec code examples'
  def spec
    exec 'rspec -I Library/Mestral --color'
  end

end

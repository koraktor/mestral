# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.formatter = :documentation
  config.mock_with :mocha
end

require 'mestral'

include Mestral

ENV['MESTRAL_PATH'] = '/usr/local/Mestral'
ENV['MESTRAL_LIBRARY'] = '/usr/local/Mestral/Library'

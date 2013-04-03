# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'spec_helper'

describe Hook::Multi do

  describe '.install' do
    it 'should install the hook wrapper for the given Git hook'
  end

  describe '.new' do
    it 'should create a new Multi instance'
  end

  describe '#execute' do
    it 'should execute the hooklets associated with this hook'
  end

end

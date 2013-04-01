# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'spec_helper'

require 'mestral/cli'

describe CLI do

  describe 'add-tape' do
    it 'should add a new tape'
    it 'should add a new tape with a given name'
  end

  describe 'update-tapes' do
    it 'should update an existing tape'
    it 'should update all existing tapes'
  end

  describe 'list' do
    it 'should return a list of all available hooks'
    it 'should return a list of all available hooks on a specific tape'
    it 'should return a list of enabled hooks in the current repository'
  end

end

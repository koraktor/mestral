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

  describe 'disable' do
    it 'should disable the given hooklet for the given hook in the current repository'
  end

  describe 'enable' do
    it 'should enable the given hooklet for the given hook in the current repository'
  end

  describe 'execute-hook' do
    it 'should execute the given Git hook in the current repository'
  end

  describe 'list' do
    it 'should return a list of all available hooks'
    it 'should return a list of all available hooklets on a specific tape'
    it 'should return a list of enabled hooks in the current repository'
  end

  describe 'update-tapes' do
    it 'should update an existing tape'
    it 'should update all existing tapes'
  end

  describe '#debug' do
    it 'should output a debug message'
  end

  describe '#init_repository' do
    it 'should initialize a Repository instance for the current working directory'
  end

  describe '#update_tape' do
    it 'should update the given tape'
  end

end

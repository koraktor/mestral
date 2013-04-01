# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'spec_helper'

require 'mestral/tape'

describe Tape do

  describe '#git' do
    it 'should execute a Git command in the context of the tape'
  end

  describe '#git_clone' do
    it 'should clone the Git repository of the tape'
  end

  describe '#git_dir' do
    it 'should return the GIT_DIR of the Git repository'
  end

  describe '#git_pull' do
    it 'should pull changes to the Git repository of the tape'
  end

  describe '#path' do
    it 'should return the file system path of the Git repository'
  end

  describe '#sha' do
    it 'should return the abbreviated commit ID of the current Git commit'
  end

end

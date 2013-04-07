# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'spec_helper'

require 'mestral/tape'

describe Tape do

  describe '.all' do
    it 'should return all tapes'
  end

  describe '.find' do
    it 'should return the tape with the given name' do
      tape = mock
      tape.expects(:exists?).returns true
      Tape.expects(:new).with('name').returns tape

      Tape.find('name').should eq(tape)
    end

    it 'should raise an error if the given tape does not exist' do
      tape = mock
      tape.expects(:exists?).returns false
      Tape.expects(:new).with('name').returns tape

      lambda { Tape.find('name') }.
        should raise_error(TapeNotFound, "The tape 'name' could not be found.")
    end
  end

  describe '.new' do
    it 'should return a new Tape instance with the given name' do
      tape = Tape.new 'tape'

      tape.name.should eq('tape')
    end
  end

  let :tape do
    tape = Tape.new 'tape'
  end

  describe '#destroy' do
    it 'should remove the tape'
  end

  describe '#exists?' do
    it 'should return whether this tape exists in the file system' do
      File.expects(:exists?).with '/usr/local/Mestral/Library/Tapes/tape'

      tape.exists?
    end
  end

  describe '#git' do
    it 'should execute a Git command in the context of the tape' do
      tape.expects(:`).with "git --git-dir #{tape.git_dir} command"

      tape.git 'command'
    end
  end

  describe '#git_clone' do
    it 'should clone the Git repository of the tape'
  end

  describe '#git_dir' do
    it 'should return the GIT_DIR of the Git repository' do
      tape.git_dir.should eq('/usr/local/Mestral/Library/Tapes/tape/.git')
    end
  end

  describe '#git_pull' do
    it 'should pull changes to the Git repository of the tape'
  end

  describe '#hooklet' do
    it 'should return the named hooklet from this tape'
  end

  describe '#hooklets' do
    it 'should return all hooklets on this tape'
  end

  describe '#path' do
    it 'should return the file system path of the Git repository' do
      tape.path.should eq('/usr/local/Mestral/Library/Tapes/tape')
    end
  end

  describe '#sha' do
    it 'should return the abbreviated commit ID of the current Git commit'
  end

end

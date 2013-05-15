# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'spec_helper'

require 'mestral/cli'

describe CLI do

  let :cli do
    Mestral::CLI.new
  end

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
    before do
      @hook = mock
      repo = mock
      repo.expects(:hook).with('pre-commit').returns @hook
      cli.expects(:repository).returns repo
    end

    it 'should execute the given successful Git hook in the current repository' do
      @hook.expects(:execute).returns true
      cli.expects(:exit).never

      cli.execute_hook '.git/hooks/pre-commit'
    end

    it 'should execute the given failing Git hook in the current repository' do
      @hook.expects(:execute).returns false
      cli.expects(:exit).with 1

      cli.execute_hook '.git/hooks/pre-commit'
    end
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

  describe 'upgrade' do
    before do
      cli.expects(:`).with 'git --git-dir /usr/local/Mestral/.git fetch origin master 2>&1'
      cli.expects(:`).with('git --git-dir /usr/local/Mestral/.git rev-parse --short HEAD').returns '01234567'
    end

    it 'should update the given tape' do
      cli.expects(:`).with('git --git-dir /usr/local/Mestral/.git rev-parse --short FETCH_HEAD').returns 'deadbeef'
      cli.expects(:`).with 'git --git-dir /usr/local/Mestral/.git --work-tree /usr/local/Mestral reset --hard --quiet FETCH_HEAD'
      cli.expects(:puts).with 'Updated Mestral from 01234567 to deadbeef'

      cli.upgrade
    end

    it 'should print a message if the tape is already up-to-date' do
      cli.expects(:`).with('git --git-dir /usr/local/Mestral/.git rev-parse --short FETCH_HEAD').returns '01234567'
      cli.expects(:puts).with 'Mestral is already up-to-date.'

      cli.upgrade
    end
  end

  describe '#debug' do
    it 'should output a debug message if --debug was passed' do
      cli.expects(:puts).with('test')
      cli.options = { :debug => true }

      cli.debug 'test'
    end

    it 'should output nothing if --debug was not passed' do
      cli.expects(:puts).never

      cli.debug 'test'
    end
  end

  describe '#init_repository' do
    it 'should initialize a Repository instance for the current working directory if it does not exist' do
      repo = mock
      Repository.expects(:current=).with do |dir|
        Repository.send :class_variable_set, :@@current, repo
        dir == Dir.pwd
      end

      cli.repository.should eq(repo)
    end

    it 'should return an existing Repository instance' do
      repo = mock
      Repository.send :class_variable_set, :@@current, repo

      cli.repository.should eq(repo)
    end
  end

  describe '#update_tape' do
    before do
      @tape = mock
      @tape.expects(:name).returns 'name'
      @tape.expects(:sha).returns '01234567'
    end

    it 'should update the given tape' do
      @tape.expects(:git_pull).returns 'deadbeef'
      cli.expects(:puts).with "Updated tape 'name' from 01234567 to deadbeef"

      cli.update_tape @tape
    end

    it 'should print a message if the tape is already up-to-date' do
      @tape.expects(:git_pull).returns '01234567'
      cli.expects(:puts).with "Tape 'name' is already up-to-date."

      cli.update_tape @tape
    end
  end

end

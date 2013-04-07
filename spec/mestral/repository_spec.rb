# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'spec_helper'

require 'mestral/repository'

describe Repository do

  describe '.current=' do
    it 'sets the current repository to the given path' do
      repo = mock
      Repository.expects(:new).with('/path/to/repository').returns repo

      Repository.current = '/path/to/repository'

      Repository.send(:class_variable_get, :@@current).should eq(repo)
    end
  end

  describe '.current' do
    it 'should return the current repository' do
      repo = mock
      Repository.send :class_variable_set, :@@current, repo

      Repository.current.should eq(repo)
    end
  end

  describe '.new' do
    it 'should create a new Repository instance for the given path' do
      Dir.expects(:chdir).with('/path/to/repository').yields
      Kernel.stubs(:`).with('git rev-parse --git-dir').returns ".git\n"

      repo = Repository.new '/path/to/repository'

      repo.git_dir.should eq('/path/to/repository/.git')
      repo.path.should eq('/path/to/repository')
    end
  end

  let :repo do
    repo = Repository.allocate
    repo.instance_variable_set :@git_dir, '/path/to/repository/.git'
    repo.instance_variable_set :@path, '/path/to/repository'
    repo
  end

  describe '#config' do
    it 'should return the Mestral configuration of the Git repository'
  end

  describe '#git_dir' do
    it 'should return the GIT_DIR of the Git repository' do
      repo.git_dir.should eq('/path/to/repository/.git')
    end
  end

  describe '#hook' do
    it 'should return the named hook of the Git repository'
  end

  describe '#hooks' do
    it 'should return all hooks of the Git repository'
  end

  describe '#hooks_dir' do
    it 'should return the path to the hooks directory of the Git repository' do
      repo.hooks_dir.should eq('/path/to/repository/.git/hooks')
    end
  end

  describe '#path' do
    it 'should return the file system path of the Git repository' do
      repo.path.should  eq('/path/to/repository')
    end
  end

end

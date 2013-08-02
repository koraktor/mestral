# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'tmpdir'

require 'spec_helper'

describe Hook::Multi do

  describe '.install' do
    it 'should install the hook wrapper for the given Git hook' do
      Dir.mktmpdir do |hooks_dir|
        repo = mock :hooks_dir => hooks_dir

        Hook::Multi.install repo, 'pre-commit'

        hook_path = File.join hooks_dir, 'pre-commit'
        File.read(hook_path).should eq("#!/usr/bin/env mestral\n")
        File.stat(hook_path).mode.should eq(0100755)
      end
    end
  end

  describe '.new' do
    it 'should create a new Multi instance'
  end

  describe '#run' do
    it 'should execute the hooklets associated with this hook'
  end

end

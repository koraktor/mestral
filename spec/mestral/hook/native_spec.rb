# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'spec_helper'

describe Hook::Native do

  let :hooks_dir do
    File.join('path', 'to', 'repo', '.git', 'hooks')
  end

  let :native do
    repo = mock :hooks_dir => hooks_dir
    Hook::Native.new repo, 'pre-commit'
  end

  describe '#execute' do
    it 'should execute the native Git hook and return if it was successful' do
      native.expects(:`).with File.join hooks_dir, 'pre-commit'
      system ''

      native.execute.should be_false
    end
  end

end

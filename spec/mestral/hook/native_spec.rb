# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'spec_helper'

describe Hook::Native do

  let :native do
    repo = mock :git_dir => git_dir
    Hook::Native.new repo, 'pre-commit'
  end

  let :git_dir do
    File.join('path', 'to', 'repo', '.git')
  end

  describe '#execute' do
    it 'should execute the native Git hook and return if it was successful' do
      native.expects(:`).with File.join git_dir, 'hooks', 'pre-commit'
      system ''

      native.execute.should be_false
    end
  end

end

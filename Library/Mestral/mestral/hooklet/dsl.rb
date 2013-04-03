# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

module Mestral::Hooklet::DSL

  def fail
    @passed = false
  end

  def git(command)
    `git --git-dir #{Mestral::Repository.current.git_dir} #{command}`
  end

  def pass
    @passed = true
  end

end

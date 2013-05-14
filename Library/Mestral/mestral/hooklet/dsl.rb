# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

module Mestral::Hooklet::DSL

  def fail
    raise Mestral::Hooklet::Finished, false
  end

  def git(command)
    `git --git-dir #{repo.git_dir} #{command}`
  end

  def config
    repo.config['%s:%s' % [tape.name, name]]
  end

  def current
    Mestral::Hook.current
  end

  def pass
    raise Mestral::Hooklet::Finished, true
  end

  def repo
    Mestral::Repository.current
  end

end

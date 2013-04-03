# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'mestral/hook'
require 'mestral/hooklet'

class Mestral::Hook::Multi < Mestral::Hook

  def self.install(repo, name)
    File.write File.join(repo.hooks_dir, name), '#!/usr/bin/env mestral'
  end

  attr_reader :hooklets

  def initialize(repo, name)
    super

    @hooklets = []
    (repo.config['hooks'] || []).each do |tape, hooklets|
      tape = Mestral::Tape.find tape
      Hash[hooklets].each do |hooklet, hook|
        @hooklets << tape.hooklet(hooklet) if hook == name
      end
    end
  end

  def execute
    @hooklets.each do |hooklet|
      hooklet.execute
      break if hooklet.failed?
    end
    @hooklets.all? &:passed?
  end

end

# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'mestral/hook'
require 'mestral/hooklet'

class Mestral::Hook::Multi < Mestral::Hook

  def self.install(repo, name)
    path = File.join(repo.hooks_dir, name)
    File.write path, '#!/usr/bin/env mestral'
    File.chmod 0755, path
  end

  attr_reader :hooklets

  def initialize(repo, name)
    super

    @hooklets = []
    (repo.config['hooks'] || []).each do |hook, hooklets|
      next unless hook == name
      hooklets = [hooklets] unless hooklets.first.is_a? Array
      hooklets.each do |tape, hooklet|
        tape = Mestral::Tape.find tape
        @hooklets << tape.hooklet(hooklet) if hook == name
      end
    end
  end

  def run
    @hooklets.each do |hooklet|
      hooklet.execute
      break if hooklet.failed?
    end
    @hooklets.all? &:passed?
  end

end

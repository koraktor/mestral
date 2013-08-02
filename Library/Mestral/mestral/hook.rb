# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

class Mestral::Hook; end

require 'mestral/errors'
require 'mestral/hook/multi'
require 'mestral/hook/native'

class Mestral::Hook

  HOOK_NAMES = %w{
    applypatch-msg pre-applypatch post-applypatch pre-commit prepare-commit-msg
    commit-msg post-commit pre-rebase post-checkout post-merge pre-receive
    update post-receive post-update pre-auto-gc post-rewrite
  }

  def self.all(repo)
    HOOK_NAMES.map { |hook| find repo, hook }.compact
  end

  def self.current
    @@current
  end

  def self.find(repo, name)
    raise Mestral::InvalidHook, name unless HOOK_NAMES.include? name

    hook_path = File.join repo.hooks_dir, name
    return nil unless File.executable? hook_path

    if File.read(hook_path, 22) == '#!/usr/bin/env mestral'
      Multi.new repo, name
    else
      Native.new repo, name
    end
  end

  attr_reader :name
  attr_reader :repo

  def initialize(repo, name)
    @name = name
    @repo = repo
  end

  def execute
    @@current = self
    passed = run
    @@current = nil
    passed
  end

  def path
    File.join repo.hooks_dir, name
  end

end

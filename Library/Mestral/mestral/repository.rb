# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'mestral/hook'

class Mestral::Repository

  def self.current=(path)
    @@current = new path
  end

  def self.current
    @@current
  end

  attr_reader :git_dir
  attr_reader :path

  def initialize(path)
    @path = File.expand_path path
    Dir.chdir @path do
      @git_dir = File.join @path, `git rev-parse --git-dir`.strip
    end
  end

  def config
    return @config unless @config.nil?

    @config = {}
    git('config --null --get-regexp "^mestral"').split("\0").
      map { |value| value.sub(/^mestral\./, '').split "\n" }.each do |kv|
      config = @config
      keys = kv[0].split('.')
      keys[0..-2].each { |key| config = config[key] ||= {} }
      config[keys.last] = kv[1]
    end
    @config
  end

  def git(command)
    `git --git-dir #{git_dir} #{command}`
  end

  def hook(name)
    Mestral::Hook.find self, name
  end

  def hooks
    Mestral::Hook.all self
  end

  def hooks_dir
    File.join @git_dir, 'hooks'
  end

end

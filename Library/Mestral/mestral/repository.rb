# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'mestral/hook'

class Mestral::Repository

  @@current = nil

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
      @git_dir = File.expand_path `git rev-parse --git-dir`.strip, @path
    end
  end

  def config
    return @config unless @config.nil?

    @config = {}
    git('config --null --get-regexp "^mestral"').split("\0").
      map { |value| value.sub(/^mestral\./, '').split "\n" }.each do |key, value|
      config = @config
      keys = key.split('.')
      key = keys.pop
      keys.each { |k| config = config[k] ||= {} }
      if config.key? key
        if config[key].is_a? Array
          config[key] << value
        else
          config[key] = [ config[key], value ]
        end
      else
        config[key] = value
      end
    end

    split_values = lambda do |value|
      if value.is_a? Hash
        Hash[value.map { |key, val| [ key, split_values.call(val) ]}]
      elsif value.is_a? Array
        value.map! { |val| split_values.call(val) }
      else
        value.include?(':') ? value.split(':') : value
      end
    end

    @config = split_values.call @config
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

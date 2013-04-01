# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'fileutils'

class Mestral::Tape

  attr_reader :author
  attr_reader :license
  attr_reader :name

  def self.find(name)
    tape = new name
    return nil unless tape.exists?
    tape.init
    tape
  end

  def initialize(name)
    @name = name
  end

  def destroy
    FileUtils.rm_rf path
  end

  def exists?
    File.exists? path
  end

  def git(command)
    `git --git-dir #{git_dir} #{command}`
  end

  def git_clone(url)
    git "clone --quiet #{url} #{path}"
    $?.success?
  end

  def git_dir
    File.join path, '.git'
  end

  def git_pull
    git 'fetch --force --quiet origin master'
    new_sha = git ' log -1 --format=format:"%h" FETCH_HEAD'
    if new_sha != sha
      git "--work-tree #{path} reset --hard --quiet FETCH_HEAD"
      @sha = new_sha
    end

    new_sha
  end

  def init
    true
  end

  def path
    File.join ENV['MESTRAL_LIBRARY'], 'Tapes', name
  end

  def sha
    @sha ||= `git --git-dir #{git_dir} log -1 --format=format:"%h" HEAD`
  end

end

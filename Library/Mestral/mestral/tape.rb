# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'fileutils'

require 'mestral/errors'

class Mestral::Tape

  TAPES_PATH = File.join ENV['MESTRAL_LIBRARY'], 'Tapes'

  attr_reader :name

  def self.all
    tape_paths = Dir.glob File.join(TAPES_PATH, '*')
    tape_paths += Dir.glob File.join(TAPES_PATH, '*', '*')
    tapes = tape_paths.select { |path| File.directory? File.join(path, '.git') }
    tapes.map { |path| path.sub TAPES_PATH + '/', '' }.map do |tape_name|
      find tape_name
    end
  end

  def self.find(name)
    tape = new name
    raise Mestral::TapeNotFound, name unless tape.exists?
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
    new_sha = git ' rev-parse --short FETCH_HEAD'
    if new_sha != sha
      git "--work-tree #{path} reset --hard --quiet FETCH_HEAD"
      @sha = new_sha
    end

    new_sha
  end

  def hooklet(name)
    Mestral::Hooklet.find self, name
  end

  def hooklets
    Dir.glob(File.join path, '*.rb').map do |file|
      Mestral::Hooklet.find self, File.basename(file, '.rb')
    end
  end

  def path
    File.join TAPES_PATH, name
  end

  def sha
    @sha ||= `git --git-dir #{git_dir} rev-parse --short HEAD`
  end

end

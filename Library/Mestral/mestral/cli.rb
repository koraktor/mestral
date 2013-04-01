# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'thor'
require 'uri'

require 'mestral'
require 'mestral/tape'

class Mestral::CLI < Thor

  class_option :debug, :type => :boolean

  desc 'add-tape', 'Add a hook tape'
  option :name, :desc => 'The name used to identify the tape'
  def add_tape(url)
    name = options[:name] || File.basename(url, '.git')
    tape = Mestral::Tape.new name
    if tape.exists?
      $stdout << "A tape with the name '#{tape.name}' already exists. Do you want to update it? [Y/n] "
      if $stdin.gets.strip.downcase != 'y'
        update_tape tape
      else
        puts 'Aborted.'
        return
      end
    else
      url = File.expand_path url if URI(url).scheme.nil?
      if tape.git_clone url
        puts "Successfully cloned tape '#{tape.name}'."
      else
        $stdout << 'Cloning the tape failed. Do you still want to keep it? [y/N] '
        tape.destroy if $stdin.gets.strip.downcase != 'y'
        return
      end
    end

    tape.init
  end

  desc 'list', 'List available hooks'
  option :enabled, :type => :boolean, :desc => 'Only list hooks currently enabled in the current repository'
  def list
    hooks = []

    if options[:enabled]
    else
    end

    if hooks.empty?
      if options[:enabled]
        puts 'There are no enabled hooks in the current repository.'
      else
        puts 'There are no available hooks.'
        puts "Use `#$0 add-tape` to add a hook tape."
      end
    else
      puts "List of #{'enabled ' if options[:enabled]}Git hooks"

      hooks.each do |hook|
        puts hook.name
      end
    end
  end

  desc 'update-tapes', 'Updates one or more hook tapes'
  def update_tapes(*tapes)
    if tapes.empty?
      tape_paths = Dir.glob File.join(ENV['MESTRAL_LIBRARY'], 'Tapes', '*')
      tapes = tape_paths.select { |path| File.directory? path }
      tapes.map! { |path| File.basename path }
    end

    tapes.each do |tape_name|
      begin
        tape = Mestral::Tape.find tape_name
      rescue
        puts "Tape '#{tape_name}' is not valid. Ignoring."
        next
      end
      if tape.nil?
        puts "Tape '#{tape_name}' does not exist. Ignoring."
      else
        update_tape tape
      end
    end
  end

  no_commands do

    def debug(message)
      puts message if options[:debug]
    end

    def update_tape(tape)
      current_sha = tape.sha
      new_sha = tape.git_pull

      if new_sha == current_sha
        puts "Tape '#{tape.name}' is already up-to-date."
      else
        puts "Updated tape '#{tape.name}' from #{current_sha} to #{new_sha}"
      end
    end

  end

end

#!/usr/bin/env ruby
#
# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'rbconfig' unless defined? RbConfig

module Font extend self
  def green; bold 34 end
  def red; bold 31 end
  def reset; escape 0 end
  def bold(n); escape "1;#{n}" end
  def escape(n); "\033[#{n}m" if !windows? && $stdout.tty? end
  def yellow; bold 33 end
end

def done
  puts "#{Font.green}Done.#{Font.reset}"
  exit 0
end

def executable?(name)
  if windows?
    ENV['PATH'].split(';').each do |path|
      return true if File.executable? File.join(path, "#{name}.exe")
    end
    false
  else
    system "which -s #{name}"
  end
end

def windows?
  RbConfig::CONFIG['host_os']  =~ /mingw|mswin32|cygwin/
end

if executable? 'brew'
  puts "#{Font.yellow}Homebrew is installed. Please install using `brew install mestral`.#{Font.reset}"
  exit
end

unless executable? 'git'
  puts "#{Font.red}Git's executable is not in your PATH. Please add it.#{Font.reset}"
  exit
end

MESTRAL_REPOSITORY = 'https://github.com/koraktor/mestral'

if windows?
  MESTRAL_PREFIX = "#{ENV['ALLUSERSPROFILE']}/Mestral"
else
  MESTRAL_PREFIX = '/usr/local/mestral'
end

puts "Cloning the Mestral repository to '#{MESTRAL_PREFIX}'"
`git clone #{MESTRAL_REPOSITORY} #{MESTRAL_PREFIX}`

target_path = ENV['PATH'].split(File::PATH_SEPARATOR).
  select { |path| File.stat(path).writable? }.
  sort_by { |path| path.length }.first

if target_path.nil?
  git_exec_path = `git --exec-path`.strip
  target_path = git_exec_path if File.stat(git_exec_path).writable?
  if target_path.nil?
    puts "#{Font.yellow}Could not find a path to link the executable.#{Font.reset}"
    done
  end
end

executable = File.join target_path, 'mestral'
if windows?
  puts "Installing the Mestral executable wrapper into '#{executable}'..."
  File.open executable, 'w' do |file|
    file << "#!/usr/bin/env ruby\n"
    file << "load '#{MESTRAL_PREFIX}/bin/mestral'\n"
  end
else
  puts "Symlinking the Mestral executable into '#{executable}'..."
  `ln -s #{MESTRAL_PREFIX}/bin/mestral #{executable}`
end

done

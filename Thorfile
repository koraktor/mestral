# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

require 'thor'

class Default < Thor

  default_command :spec

  desc 'spec', 'Run RSpec code examples'
  def spec
    exec 'rspec -I Library/Mestral --color'
  end

  desc 'unpack-gems', 'Unpack gem dependencies'
  def unpack_gems
    require 'fileutils'
    require 'bundler'

    vendored_gem_path = File.join(File.dirname(__FILE__), 'Library', 'Gems')
    FileUtils.rm_rf vendored_gem_path

    Bundler.definition.specs_for([:default]).each do |gem|
      next if gem.name == 'bundler'
      `gem unpack #{gem.name} -v '#{gem.version}' --target=#{vendored_gem_path}`
    end
  end

end

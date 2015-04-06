# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

$:.unshift("./lib/")

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'ib-osx'
  app.frameworks.concat [
    'AVFoundation',
    'CoreMedia'
  ]

  Dir.glob(File.join(File.dirname(__FILE__), 'lib/*/*.rb')).each do |file|
    app.files.unshift(file)
  end
end

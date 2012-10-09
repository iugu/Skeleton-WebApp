require 'bundler/setup'
require 'sprockets'

Bundler.require(:default)

require './webapp'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'src/statics'
  environment.append_path 'src/js'
  environment.append_path 'src/css'
  run environment
end

run WebApp

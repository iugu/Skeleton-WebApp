require 'bundler/setup'
require 'sprockets'

Bundler.require(:default)

require './webapp'

map '/assets' do
  run $environment
end

run WebApp

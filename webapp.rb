require 'sinatra/base'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

Compass.configuration do |compass|
  compass.sprite_load_path = [ 'src/sprites', IuguUX.sprite_load_path ]
  compass.images_dir = 'src/statics/i'
  compass.http_generated_images_path = '/assets/i'
end

$environment = Sprockets::Environment.new
$environment.append_path 'src/statics'
$environment.append_path 'src/js'
$environment.append_path 'src/css'
$environment.append_path IuguUX.assets_path + '/javascripts'
$environment.append_path IuguUX.assets_path + '/stylesheets'

class WebApp < Sinatra::Base
  set :views, settings.root + '/src/templates'

  get '/manifest.appcache' do
    erb :manifest, :locals => { :assets => $environment }
  end

  get '/*' do
    erb :index, :locals => { :assets => $environment }
  end
end

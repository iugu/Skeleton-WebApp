require 'sinatra/base'

Compass.configuration do |compass|
end

class WebApp < Sinatra::Base
  set :views, settings.root + '/src/templates'

  get '/*' do
    erb :index 
  end
end

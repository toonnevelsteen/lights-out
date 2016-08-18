require 'sinatra'
require 'haml'
require './light'

class LightsOutApp < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/on' do
    Light.on
    haml :on  
  end

  get '/out' do
    Light.off
    haml :out  
  end

end


require 'sinatra'
require 'haml'

class LightsOutApp < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/on' do
    haml :on  
  end

  get '/out' do
    haml :out  
  end

end


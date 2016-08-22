require 'sinatra'
require 'haml'
require './light'
require './workers/lights_worker'

class LightsOutApp < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/on' do
    Light.on
    redirect '/'
  end

  get '/out' do
    Light.off
    redirect '/'
  end

  get '/auto' do
    light = Light.new
    puts "Scheduling ..."
    Sidekiq::ScheduledSet.new.clear
    LightsOnWorker.perform_at(light.auto_on_time)
    LightsOutWorker.perform_at(light.auto_off_time)
    haml :auto, locals: {light: light}
  end

end



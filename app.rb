require 'sinatra'
require 'haml'
require './light'
require './workers/lights_worker'

class LightsOutApp < Sinatra::Base

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == ENV['USERNAME'] and password == ENV['USER_PASSWORD']
  end

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

  get '/info' do
    light = Light.new
    "{
      'auto_off_time': #{light.auto_off_time},
      'auto_on_time': #{light.auto_on_time}
    }"
  end

end



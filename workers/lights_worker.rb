# Make sure you have Sinatra installed, then start sidekiq with
# ./bin/sidekiq -r ./examples/sinkiq.rb
# Simply run Sinatra with
# ruby examples/sinkiq.rb
# and then browse to http://localhost:4567
#
require 'sinatra'
require 'sidekiq'
require 'redis'
require 'sidekiq/api'

class LightsOutWorker
  include Sidekiq::Worker

  def perform(msg="a msg!")
		light = Light.new
    light.off
  end
end

class LightsOnWorker
  include Sidekiq::Worker

  def perform(msg="a msg!")
		light = Light.new
    light.on
  end
end

# get '/' do
#   stats = Sidekiq::Stats.new
#   @failed = stats.failed
#   @processed = stats.processed
#   @messages = $redis.lrange('sinkiq-example-messages', 0, -1)
#   erb :index
# end

# post '/msg' do
#   SinatraWorker.perform_async params[:msg]
#   redirect to('/')
# end
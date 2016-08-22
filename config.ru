require "./app"

require 'sidekiq/web'

run Rack::URLMap.new('/' => LightsOutApp, '/sidekiq' => Sidekiq::Web)


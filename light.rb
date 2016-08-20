require './solareventcalculator.rb'
if `hostname`.strip == 'Toons-MacBook-Pro.local'
  require './fake_rpi_gpio'
else
  require 'rpi_gpio'
end

require 'active_support'
require 'active_support/core_ext'

class Light

  PIN = 16

  attr_accessor :auto_off_time, :auto_on_time

  def initialize
    RPi::GPIO.set_numbering :board
    RPi::GPIO.setup PIN, :as => :output

    @auto_off_time = Time.now.end_of_day
    @auto_on_time = sunset

  end

  def on
    RPi::GPIO.set_low PIN
  end

  def off
    RPi::GPIO.set_high PIN
  end

  def self.on
    Light.new.on
  end

  def self.off
    Light.new.off
  end

  def sunset
    solar_events = SolarEventCalculator.new(Date.today, 51.0523800,4.8806800) #for Herselt
    solar_events.compute_utc_civil_sunset.to_time
  end

  def sunrise
    solar_events = SolarEventCalculator.new(Date.today, 51.0523800,4.8806800) #for Herselt
    solar_events.compute_utc_civil_sunrise.to_time
  end

  def auto
    light = Light.new
    time = Time.now
    if time < light.auto_off_time && time > light.auto_on_time
      light.on
    else
      light.off
    end
  end
end

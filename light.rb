require 'rpi_gpio'
require './solareventcalculator.rb'

class Light

  PIN = 16

  def initialize
    RPi::GPIO.set_numbering :board
    RPi::GPIO.setup PIN, :as => :output
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
end

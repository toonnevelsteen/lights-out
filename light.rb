require 'rpi_gpio'

class Light

  PIN = 16

  def initialize
    RPi::GPIO.set_numbering :board
    RPi::GPIO.setup PIN, :as => :output
  end

  def on
    RPi::GPIO.set_high PIN
  end
  
  def off
    RPi::GPIO.set_low PIN
  end

  def self.on
    Light.new.on
  end

  def self.off
    Light.new.off
  end
end

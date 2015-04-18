require 'rubygems'
require 'unimidi'
require 'lifx'

looped = true
@input = UniMIDI::Input.gets

# mode of lighting
# 0 = hold (default)
# 1 = flash
# 2 = fade
@mode = 0
@flash_duration = 1

@client = LIFX::Client.lan
@client.discover!
@light = @client.lights.with_label('Room HOLMO')

@red = LIFX::Color.red(saturation: 1.0)
@green = LIFX::Color.green(saturation: 1.0)
@blue = LIFX::Color.blue(saturation: 1.0)
@white = LIFX::Color.white()
@black = LIFX::Color.new(0, 0, 0, 3500)
@lastcolor = @black


## HELPERS
def fade_to_black(mode=0)
  duration = 0
  if mode == 2
    duration = 1
  end

  if mode != 0
    @light.set_color(LIFX::Color.new(@lastcolor.hue, @lastcolor.saturation, 0.1, 3500), duration: duration)
  end
end

def show_color(color)
  @lastcolor = color
  @light.set_color(color, duration: 0)
  puts("Color: #{color}")
end

def cycle_mode()
  if @mode == 2
    @mode = 0
  else
    @mode += 1
  end

  puts "Mode: #{@mode}"
end


## LOOP
num = 1000
num.times do
  m = @input.gets
  data = m.first[:data]
  timestamp = m.first[:timestamp]

  type = data[0]      # 144 = keydown, 128 = keyup
  key = data[1]       # key on MIDI board
  pressure = data[2]  # pressure of key - 0 to 127

  if type == 144
    hue_decimal = key / 120.0
    hue = hue_decimal * 360.0

    sat = pressure / 127.0
    color = LIFX::Color.new(hue, 1.0, sat, 3500)
    show_color(color)
  end

  # if type == 144
  #   if key == 48
  #     show_color(@red)
  #   elsif key == 50
  #     show_color(@green)
  #   elsif key == 52
  #     show_color(@blue)
  #   elsif key == 53
  #     show_color(@white)
  #   elsif key == 72
  #     cycle_mode()
  #   end
  # end

  if type == 128
    # set colour to black
    fade_to_black(mode=@mode)
  end

end
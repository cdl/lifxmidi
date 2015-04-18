require 'rubygems'
require 'unimidi'

@input = UniMIDI::Input.gets

1000.times do
  m = @input.gets
  data = m.first[:data]
  time = m.first[:timestamp]

  typ = data[0]
  key = data[1]
  vel = data[2]

  puts "Type: #{typ} / Key: #{key} / Vel: #{vel}"
end
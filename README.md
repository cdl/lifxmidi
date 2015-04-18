# lifxmidi

I wanted to control my LIFX bulb with a MIDI controller, so this is the project for that.

I'm well aware that this is entirely spaghetti code, but hey, it works for me. I'm using an AKAI MPK Mini, so the keycodes are all mapped up for that. I'm sure your MIDI keyboard has different keycodes, so, this probably won't work out of the box.

This project utilizes the wonderful [unimidi](https://github.com/arirusso/unimidi) gem, as well as the official [lifx-gem](https://github.com/LIFX/lifx-gem) gem, which supposedly doesn't work with 2.0 LIFX firmware, but it seems to be working fine with my 2.0 bulb? ¯\_(ツ)_/¯

* * *

Disclaimer: if you try and get this working with your setup, you do so at your own risk. I'm not held responsible if you mess up your $80 smart lightbulb. It shouldn't... but I'd rather not take any chances.
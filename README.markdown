Version: 1.0.1
Last Change: 2012 Oct 18

# Sunset

## Introduction

Sunset automatically sets `background` when you start Vim, and also at the local sunrise and sunset times for your location. When the sun is up, it'll `set background=light` and when the sun is down, it'll `set background=dark`.

You must set some options in your `.vimrc` for this to work, so please read on for details.

If you feel that Sunset can be improved, pull requests and issues are appreciated and humbly requested.

## Installation

If you don't already have a preferred method, I recommend installing [Vundle](https://github.com/gmarik/vundle). In which case, just add `Bundle 'amdt/sunset'` to your `.vimrc` and you'll be set!

## Options

### g:sunset\_latitude & g:sunset\_longitude

*Note:* If you push your dotfiles to Github, please see the section titled 'A Reminder of Privacy'.

The latitude and longitude of your location in decimal. Values North and East must be positive values, those South and West must be negative.

London, for example, lies at 51 degrees, 30 minutes North; and 7 minutes West.

In decimal, this is 51.5 degrees North, 0.1167 degrees West.

If you lived in London, you might set these options as follows:

```vim
let g:sunset_latitude = 51.5
let g:sunset_longitude = -0.1167
```

If you lived in Tokyo (35 degrees, 40 minutes and 12 seconds North; 139 degrees, 46 minutes and 12 seconds East), you might set these options as follows:

```vim
let g:sunset_latitude = 35.67
let s:sunset_longitude = 139.8
```

*Note:* Don't forget, negative values South and West.

### g:sunset\_utc\_offset

The difference in hours between your timezone and Coordinated Universal Time.

For example:

```vim
let g:sunset_utc_offset = 0 " London
let g:sunset_utc_offset = 1 " London (British Summer Time)
let g:sunset_utc_offset = 9 " Tokyo
```

*Note:* Sunset does not handle any daylight savings civil times.

## A Reminder of Privacy

For those of us who publish our dotfiles on Github etc., please take this as a gentle reminder that out of habit you might be about to publish your whereabouts to the greater public. If this concerns you, using the location of your nearest large city might suffice; Sunset will be plenty accurate enough.

## Credit

Sunset uses an algorithm for finding the local sunrise and sunset times [published in the Almanac for Computers](http://williams.best.vwh.net/sunrise_sunset_algorithm.htm), 1990, by the Nautical Almanac Office of the United States Naval Observatory.

## License

Distributed under the same terms as Vim. See ':help license'.

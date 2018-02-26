Version: 3.1.0  
Date: 2015-02-28

# Sunset

## Project Status

This project is unmaintained and archived.  Feel free to exercise your right under the license to fork this
project.

## Introduction

Sunset automatically sets `background` when the sun rises and sets, and also
when you start Vim.  When the sun is up, or rises, it'll `set background=light`
and when the sun is down, or sets, it'll `set background=dark`.

Sunset can also change your `colorscheme`, your [Powerline
theme](https://github.com/Lokaltog/vim-powerline), or anything else you can
think of.  See `Sunset_daytime_callback()` and `Sunset_nighttime_callback()` in
the documentation for details.

So as not to interrupt you, Sunset waits for four seconds (on the `CursorHold`
event) after you've pressed a key or left insert mode before changing the
background.  If you change your background during the day or night, it'll
respect that.

You must set some options in your `.vimrc` for Sunset to work, so please read
on for details.

If you feel that Sunset can be improved, pull requests (on the `develop`
branch, please) and issues are appreciated and humbly requested.

## Installation

If you don't already have a preferred installation method, I recommend
installing [Vundle](https://github.com/gmarik/vundle).  Once done, add the
declaration for Sunset to your `.vimrc`:

```VimL
Bundle 'amdt/sunset'
```

And install:

```VimL
:BundleInstall
```

*Note:* other installation methods are detailed in the included
documentation.

## Requirements

* Sunset requires Vim 7.3
* Vim compiled with `+float` support.  Use `:version` to check if this feature
  is available in your build.
* Requires a system with `strftime()`, with the following format options:

  * `%j` returns the current day of the year.
  * `%H` returns the current hour of the day in 24-hour time.
  * `%M` returns the current minute of the hour.

*Note*: If your system's `strftime()` differs, please [open an issue on the
project's GitHub page](https://github.com/amdt/sunset/issues) with details.

### Recommended:

* A colorscheme with light and dark variants, such as
  [Solarized](https://github.com/altercation/vim-colors-solarized) or
  [Hemisu](https://github.com/noahfrederick/Hemisu).

## Configuration

*Note:* If you push your dotfiles to (for example) GitHub, please see the
section titled 'A Reminder on Privacy'.

### g:sunset\_latitude & g:sunset\_longitude

The latitude and longitude of your location in decimal.  Values North and East
must be positive values, those South and West must be negative.

London, for example, lies at 51 degrees, 30 minutes North; and 7 minutes West.

In decimal, this is 51.5 degrees North, 0.1167 degrees West.

If you lived in London, you might set these options as follows:

```VimL
let g:sunset_latitude = 51.5
let g:sunset_longitude = -0.1167
```

If you lived in Tokyo (35 degrees, 40 minutes and 12 seconds North; 139
degrees, 46 minutes and 12 seconds East), you might set these options as
follows:

```VimL
let g:sunset_latitude = 35.67
let g:sunset_longitude = 139.8
```

*Note:* Don't forget, negative values South and West.

### g:sunset\_utc\_offset

The difference in hours between your timezone and Coordinated Universal Time.

For example:

```VimL
let g:sunset_utc_offset = 0 " London
let g:sunset_utc_offset = 1 " London (British Summer Time)
let g:sunset_utc_offset = 9 " Tokyo
```

*Note:* Sunset does not handle any daylight savings civil times.

## A Reminder on Privacy

For those of us who publish our dotfiles on (for example) GitHub etc., please
take this as a gentle reminder that out of habit you might be about to publish
your whereabouts to the greater public.  If this concerns you, using the
location of your nearest large city might suffice; Sunset will be plenty
accurate enough.

## License

Sunset is distributed under the same terms as Vim itself. See `:help license`
for details.

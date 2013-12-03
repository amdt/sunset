:Version: 2.0.0
:Date: 2013-01-12

========
 Sunset
========

2.0.0
-----

**Note:** Sunset 2.0.0 breaks compatibility with previous versions of Sunset
for users of the ``sunset_callback()`` callback.  ``sunset_daytime_callback()``
and ``sunset_nighttime_callback()`` are unaffected.

Introduction
------------

Sunset automatically sets ``background`` when the sun rises and sets, and also
when you start Vim.  When the sun is up, or rises, it'll ``set
background=light`` and when the sun is down, or sets, it'll ``set
background=dark``.

Sunset can also change your ``colorscheme``, your Powerline_ theme, or anything
else you can think of.  See ``sunset_daytime_callback()`` and
``sunset_nighttime_callback()`` in the documentation for details.

So as not to interrupt you, Sunset waits for four seconds (on the
``CursorHold`` event) after you've pressed a key or left insert mode before
changing the background.  If you change your background during the day or
night, it'll respect that.

You must set some options in your ``.vimrc`` for Sunset to work, so please read
on for details.

If you feel that Sunset can be improved, pull requests (on the ``develop``
branch, please) and issues are appreciated and humbly requested.

.. _Powerline: https://github.com/Lokaltog/vim-powerline

Installation
------------

If you don't already have a preferred installation method, I recommend
installing Vundle_. Once done, add the declaration for Sunset to your
``.vimrc``:

.. code:: vim
   Bundle 'amdt/sunset'

And install:

.. code:: vim
   :BundleInstall

**Note:** other installation methods are detailed in the included
documentation.

.. _Vundle: http://github.com/gmarik/vundle

Requirements
------------

* Sunset requires Vim 7.3
* Vim compiled with ``+float`` support. Use ``:version`` to check if this
  feature is available in your build.
* Requires a system with ``strftime()``, with the following format options:

  + ``%j`` returns the current day of the year.
  + ``%H`` returns the current hour of the day in 24-hour time.
  + ``%M`` returns the current minute of the hour.

Note: If your system's |strftime()| differs, please open an issue on the
Github page at: http://github.com/amdt/sunset/issues with details.

Recommended:
~~~~~~~~~~~~

* A colorscheme with light and dark variants, such as Solarized_ or Hemisu_.

.. _Solarized: http://github.com/altercation/vim-colors-solarized
.. _Hemisu: http://github.com/noahfrederick/Hemisu

Configuration
-------------

**Note:** If you push your dotfiles to (for example) Github, please see the
section titled '`A Reminder on Privacy`_'.

g:sunset_latitude & g:sunset_longitude
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The latitude and longitude of your location in decimal.  Values North and East
must be positive values, those South and West must be negative.

London, for example, lies at 51 degrees, 30 minutes North; and 7 minutes West.

In decimal, this is 51.5 degrees North, 0.1167 degrees West.

If you lived in London, you might set these options as follows:

.. code:: vim
   let g:sunset_latitude = 51.5
   let g:sunset_longitude = -0.1167

If you lived in Tokyo (35 degrees, 40 minutes and 12 seconds North; 139
degrees, 46 minutes and 12 seconds East), you might set these options
as follows:

.. code:: vim
   let g:sunset_latitude = 35.67
   let g:sunset_longitude = 139.8

**Note:** Don't forget, negative values South and West.

g:sunset_utc_offset
~~~~~~~~~~~~~~~~~~~

The difference in hours between your timezone and Coordinated Universal Time.

For example:

.. code:: vim
   let g:sunset_utc_offset = 0 " London
   let g:sunset_utc_offset = 1 " London (British Summer Time)
   let g:sunset_utc_offset = 9 " Tokyo

**Note:** Sunset does not handle any daylight savings civil times.

A Reminder on Privacy
---------------------

For those of us who publish our dotfiles on (for example) Github etc., please
take this as a gentle reminder that out of habit you might be about to publish
your whereabouts to the greater public.  If this concerns you, using the
location of your nearest large city might suffice; Sunset will be plenty
accurate enough.

License
-------

Sunset is distributed under the same terms as Vim itself. See ``:help license``
for details.

alyxproject
===========

ALyX (Approximately Lisa on uniX; the y is a Half-Life 2 reference with no other meaning) is a project to build a (rough) model of an Apple Lisa based around a Raspberry Pi and/or Beaglebone Black, using Ray Arachelian's Lisaem for Lisa software, Paul Pratt's mini vMac for old Mac software, and Free Pascal for Unix-side utilities.

Software
--------

Software specifically written for this project is licensed under the 3-clause ("new") BSD license. 

hvac (How to View ALyX Control) will be the startup manager; it will include a GUI (probably constructed in Lazarus) based on the Lisa Environments dialog to pick between operating environments, as well as handling startup and shutdown events from hardware buttons attached to the RPi's GPIO headers. (This is not written yet and will likely be written in Python.)

lash (Lisaesque Application Shell) is loosely based on the menu-driven command line of the Lisa Workshop shell, heavily modified for working in a Linux/OS X environment. It's being written in Free Pascal and should run on any Unix environment that it supports. (It may also run in Cygwin.)

stata (STATionery Arranger -- named for a hideous Frank Gehry building at MIT) will be a set of scripts implementing a simple stationery pad model for Linux.

Hardware
--------

The current plan is to use a Raspberry Pi 2 Model B as the system board, with an off-the-shelf powered USB hub as power source and expansion backplane. The RPi will likely use a wireless keyboard and mouse with Wifi and Bluetooth added, but don't expect those to be visible to the emulators. 

The case is approximately 4/5 scale, dictated by the choice of monitor (http://www.adafruit.com/products/1287, 10in HDMI 4 Pi kit). The shell will be painted plexiglas, mounted on a frame made of either PVC pipe or angle iron; sketches of both designs, as well as the templates for the front and side panels of the case, will be available here in LibreOffice (ODF) format. 

Dependencies
------------
The following third-party software is expected to be required for the project and is under the author's own licenses:

* Free Pascal and Lazarus (www.freepascal.org) - development language for lash and the hvac GUI
* Lisaem (lisa.sunder.net) by Ray Arachelian - Lisa hardware emulator
* Mini vMac (www.gryphel.com/c/minivmac) - early Macintosh hardware emulator
* cdrtools (www.cdrecord.org) by Jörg Schilling - mainly for mkisofs 
* old Lisa and Mac system software and ROMs - You'll have to find those. Apple owns the copyrights but they're considered abandonware. 
* GNU wget (may substitute cURL at a whim)
* Homebrew (http://brew.sh) (Mac) or apt-get (Linux) -- to install dependencies

Issues
------

* Lisaem is incredibly sluggish on the original RasPi. I've upgraded to a RPi 2.
* No effort whatsoever will be made to support any compiler other than Free Pascal. GNU Pascal is stagnant, p2c and ETH Px are too archaic, and frankly, no dialects other than Delphi (which is what Free Pascal supports) matter anymore. FPC is open source, so live with it.
* My Pascal code is terrible. Patches and general cleanup are welcome.

Contact
=======
The project owner is Brian Connors; you can contact me at connorbd@yahoo.com with suggestions, additions, and patches. Flames, as always, go to /dev/null.

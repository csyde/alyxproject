alyxproject
===========

ALyX (Approximately Lisa on uniX; the y is a Half-Life 2 reference with no other meaning) is a project to build a (rough) model of an Apple Lisa based around a Raspberry Pi and/or Beaglebone Black, using Ray Arachelian's Lisaem for Lisa software, Paul Pratt's mini vMac for old Mac software, and Free Pascal for Unix-side utilities.

Software
--------

Software specifically written for this project is licensed under the 3-clause ("new") BSD license. 

hvac (How to View ALyX Control) will be the startup manager; it will include a GUI (probably constructed in Lazarus) based on the Lisa Environments dialog to pick between operating environments, as well as handling startup and shutdown events from hardware buttons attached to the RPi's GPIO headers. (This is not written yet and will likely be written in Python.)

lash (Lisaesque Application Shell) is loosely based on the menu-driven command line of the Lisa Workshop shell, heavily modified for working in a Linux/OS X environment. It's being written in Free Pascal and should run on any Unix environment that it supports. (It may also run in Cygwin.)

stata (STATionery Arranger -- named for a hideous Frank Gehry building at MIT) will be a set of scripts implementing a simple stationery pad model for Linux.

The following third-party software is expected to be part of the project and is under the author's own licenses:

Free Pascal and Lazarus (www.freepascal.org) - development language for lash and the hvac GUI
Lisaem (lisa.sunder.net) - Lisa hardware emulator
Mini vMac (www.gryphel.com/c/minivmac) - early Macintosh hardware emulator
old Lisa and Mac system software and ROMs - You'll have to find those. Apple owns the copyrights but they're considered abandonware.

Hardware
--------

The current plan is to use a Raspberry Pi B+ as the system board, with the Beaglebone Black as a secondary target and an off-the-shelf powered USB hub as power source and expansion backplane. The RPi will likely use a wireless keyboard and mouse with Wifi and Bluetooth added, but don't expect those to be visible to the emulators. 

The case is approximately 4/5 scale, dictated by the choice of monitor (http://www.adafruit.com/products/1287, 10in HDMI 4 Pi kit). The shell will be painted plexiglas, mounted on a frame made of either PVC pipe or angle iron; sketches of both designs, as well as the templates for the front and side panels of the case, will be available here in LibreOffice (ODF) format. 

Dependencies
------------

*Free Pascal 2.6.x
*LisaEm by Ray Arachelian
*Mini vMac by Paul Pratt
*cdrtools by Jörg Schilling
*A functioning POSIX environment (Linux and OS X are dev platforms)

Contact
=======
The project owner is Brian Connors; you can contact me at connorbd@yahoo.com with suggestions, additions, and patches. Flames, as always, go to /dev/null.

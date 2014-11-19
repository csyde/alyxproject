alyxproject
===========

ALyX (Approximately Lisa on uniX; the y is a Half-Life 2 reference with no other meaning) is a project to build a (rough) model of an Apple Lisa based around a Raspberry Pi and/or Beaglebone Black, using Ray Arachelian's Lisaem for Lisa software, Paul Pratt's mini vMac for old Mac software, and Free Pascal for Unix-side utilities.

Software
========

Software specifically written for this project is licensed under the 3-clause ("new") BSD license. 

hvac (How to View ALyX Control) will be the startup manager; it will include a GUI (probably constructed in Lazarus) based on the Lisa Environments dialog to pick between operating environments, as well as handling startup and shutdown events from hardware buttons attached to the RPi's GPIO headers. (This is not written yet and will likely be written in Python.)

lash (Lisaesque Application Shell) is loosely based on the menu-driven command line of the Lisa Workshop shell, heavily modified for working in a Linux/OS X environment. It's being written in Free Pascal and should run on any Unix environment that it supports. (It may also run in Cygwin.)

stata (STATionery Arranger -- named for a hideous Frank Gehry building at MIT) will be a set of scripts implementing a simple stationery pad model for Linux.

The following third-party software is expected to be part of the project and is under the author's own licenses:

Free Pascal and Lazarus (www.freepascal.org) - development language for lash and the hvac GUI
Lisaem (lisa.sunder.net) - Lisa hardware emulator
Mini vMac (www.gryphel.com/c/minivmac) - early Macintosh hardware emulator
old Lisa and Mac system software and ROMs - You'll have to find those. Apple owns the copyrights but they're considered abandonware.

The project owner is Brian Connors; you can contact me at connorbd@yahoo.com with suggestions, additions, and patches. Flames, as always, go to /dev/null.

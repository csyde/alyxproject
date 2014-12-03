ALyX Registry docs
==================

ALyX uses a simple text-based registry for configuration purposes which controls several functions, including default programming environments, environment state, and helper programs. This document explains the options that might appear.

This is needed for a number of reasons; customizability is an obvious one, but also because I'm developing the code on a Mac to be deployed on Linux, and a lot of functions (particularly ones needed by lash) are very platform-dependent -- Apple fdisk and Linux fdisk are nothing alike, for example, and GUI apps are handled very differently on the command line, so the ALyX registry abstracts all that. 

File format
-----------

(This is subject to change.)

The registry's name for production code will be ~/.alyx_env (remove the period for testing versions). It's a standard .ini file, parsed with the FCL INIFiles unit. Right now, everything is in one big block titled [ALYX_ENV], though that may change as the list of things for it to store gets longer. 

Key definitions
---------------

* basicEnv: Should point to a Basic interpreter like Chipmunk or Brandy. (Probably Brandy, if you're on a Raspberry Pi.) 
* diskMnt: default shell command for mounting disk volumes. If not present, should default to the same as imgMnt.
* dpart: default disk partitioning shell command. Should be an interactive environment; will usually be some permutation of fdisk or gparted.
* editor: standard text editor to launch. Should default to nano so as to avoid pointless, decades-old religious wars.
* fsckIt: default shell command for Scavenge function. Usually some permutation of fsck.
* launchEnv: the list of programs for hvac to launch on startup. (This will be defined in a separate section of this document.)
* lisaEm: the location of the LisaEm app
* macEm: the location of the Mac emulator app (will generally be Mini vMac)
* imgMnt: default shell command for mounting disk images. 
* nativeIDE: default IDE for native development (usually a language-neutral IDE like Xcode or Code::Blocks, but something like QtCreator or Python IDLE is fine as well)
* pascalIDE: default IDE for Pascal development. Will usually be Lazarus or textmode IDE.
* shell: Will pretty much always be bash. Could be ksh93 or Powershell/pash if you happen to swing that way.

Notes
-----

* On the Mac, GUI applications will usually be invoked with 'open /Applications/xxx.app'.

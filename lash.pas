{ 	* lash.pas
	* the Lisaesque App Shell
	* part of the ALyX project
	* 
	* lash is a simple menu-driven shell based on the Lisa Workshop shell. It is entirely
	* menu driven and kicks back to the default shell (usually bash or BusyBox) to 
	* actually run scripts and programs. It can be invoked from the command line or 
	* as an hvac option on startup.
	*
	* This code is tested and expected to work on fpc on Mac OS X/amd64, Linux/amd64, and
	* Linux/ARM, as well as (occasionally) Cygwin/x64. Testing on other platforms is welcome.
	*
	* ©2014 Brian Connors under the three-clause BSD license
	* 	see http://opensource.org/licenses/BSD-3-Clause for license text
	}

program lash;
	
{$mode objfpc}
{$H+}	{ stfu about ansistrings in fpsystem. Also makes the long pathname problem go away. }

uses Classes,SysUtils,INIFiles,Unix;

	var
		menuCmd: char;
		pathname: string; 	{ 	file pathname. Uses Unix syntax, not Lisa (too obscure
								and too much of a pain in the ass to translate). }
		escToShell: boolean; 
		INI:TINIFile;
	
	procedure aboutBox;
		begin
			writeln('lash is the Lisaesque App Shell');
			writeln('very loosely based on Apple''s Lisa Workshop');
			writeln('©2014 Brian Connors. Part of the ALyX project.');
			writeln('licensed under the 3-clause BSD license');
			fpSystem('uname -v');
		end; 
	
	{ procedure makeImage -- creates a disk image isoOut from a specified directory path
		requires mkisofs to be installed; resulting image is ISO 9660-Joliet 
		This probably should not be hardcoded, but unless Schily suddenly abandons
		cdrtools, you probably won't want to use any other program. }
		
	procedure makeImage(path, isoOut, vname: string);
		begin
			fpSystem('mkisofs -r -J -o ' + isoOut + ' -V ' + vname + ' ' +path);
		end;
	
	{ procedure launchExt -- looks up a shell command in the registry file and executes it }
	{ 	If ALyX gets to the point where a libalyx might be useful, this is the first candidate
		to break out into a new API. }
		
	procedure launchExt(iniBlock, regkey, fn: string);
		var extCmd: string;
	
		begin
			extCmd := INI.ReadString(iniBlock, regKey,'');
			fpsystem(extCmd + fn);
		end;
						
	procedure diskMenu;
		var
			src: String; 
			dest: String; 
			vname: String; 
			
		begin
			repeat 
			writeln('Disk-tools: Format, make Image, Mount, New folder, Unmount, Burn image, Scavenge, show Online disks');
			readln(menuCmd);
			case menuCmd of
				'm': writeln('m mounts specified disk image or device');
				'i': begin
					writeln('source directory?');
					readln(src);
					writeln('volume name?');
					readln(vname);
					writeln('image filename?');
					readln(dest);
					makeimage(src, dest, vname);
				end;
				
				'b': writeln('b copies an image to an empty disk or optical drive');
				'c': writeln('s invokes fsck or scandisk');
				'q': writeln('q exits to File menu');
				'f': writeln('f invokes fdisk');
				'o': fpSystem('mount'); 	{ show Online volumes }
				
				'n': begin 	{ create New folder }
					write('new folder: ');
					readln(pathname);
					mkdir(pathname);
				end;
				
				'?': writeln('? prints man page');
				'h': writeln('h also prints man page');
				
			else
				writeln('Unfamiliar command.');
			end;
		until menuCmd = 'q';
	end;
	
	{ procedure fileMenu - basic file operations using standard Free Pascal functions }
	
	procedure fileMenu;
		var
			src: String;
			dest: String;
			
		begin
			{$I-}
			repeat 
			writeln('File-mgr: Backup, Copy, Remove, Move, List, Where, New folder, Online-volumes, Disk-tools, set-Path, Quit-to-main?');
			readln(menuCmd);
			case menuCmd of
				'w': begin 		{ Where (aka pwd) }
					getdir(0,pathname);
					writeln('current folder: ', pathname);
				end;
				
				'm': begin 	{ move/rename a file }
					write('original:');
					readln(src);
					write('new location:');
					readln(dest);
					fpsystem('mv ' + src + ' ' + dest);
				end;
				
				'r': writeln('r deletes a file (y/n?)');
				
				'p': begin 		{ set-Path (aka cd) }
					write('change to: ');
					readln(pathname);
					chdir(pathname);
					if IOResult <> 0 then writeln('Invalid folder: ',pathname);
				end;
				
				'l': fpsystem('ls -l');
				
				'b': writeln('b backs up your working environment (pathname defined in ~/.lashrc)');
				
				'c': begin 	{ copy a file }
					write('source file:');
					readln(src);
					write('destination:');
					readln(dest);
					fpsystem('cp -R ' + src  + ' ' + dest);
				end;
				
				'q': writeln('q exits to main menu');
				'd': diskMenu;
				'e': writeln('e invokes diff');
				'o': fpSystem('mount');
				'n': begin 	{ create New folder }
					write('new folder: ');
					readln(pathname);
					mkdir(pathname);
				end;
				'?': writeln('? prints man page');
				'h': writeln('h also prints man page');
				
			else
				writeln('Unfamiliar command.');
			end;
		until menuCmd = 'q';
		
		{$I+}
	end;
		
	
	procedure sysMenu;
		begin
			repeat 
			writeln('Sysutils: Manage-processes, lash-Preferences, Backup-prefs, Startup-prefs, Validate, Console, Quit-to-main?');
			readln(menuCmd);
			case menuCmd of
				'p': writeln('p shows lash-preferences menu');
				'm': writeln('m shows processes menu');
				'o': writeln('o redirects output to a file');
				'v': writeln('v checksums specified file');
				'b': writeln('b backs up your .alyxrc');
				'c': fpsystem('bash'); 	{ just kicks you out to bash, then back when you're finished }
				's': writeln('s starts the hvac gui');
				'q': writeln('q exits to main menu');
				'?': writeln('? prints man page');
				'h': writeln('h also prints man page');
				
			else
				writeln('Unfamiliar command.');
			end;
		until menuCmd = 'q';
	end;
	
	{ main prompt }
	
	begin
		writeln('Lisaesque App Shell');
		writeln('©2014 Brian Connors as part of the ALyX project');
		escToShell := false;
		
		INI := TINIFile.Create('./alyx_reg'); { load and parse registry file }
		
		repeat 
			writeln('File-mgr, Sysutils, Edit, Debug, Pascal, Basic, C, Web browser, Grab-URL, ?Help, Run shell-cmd, Quit?');
			readln(menuCmd);
			case menuCmd of
				'f': fileMenu;
				's': sysMenu;
				
				'e': begin { edit file }
					write('filename?');
					readln(pathname);
					launchExt('ALYX_ENV','editor',pathname);
				end;
				
				'd': writeln('d invokes debugger (default gdb)');
				
				'p': launchExt('ALYX_ENV','pascalIDE',''); 	{ probably should invoke compilers instead? }	
				'b': writeln('b invokes Basic interpreter (default Chipmunk Basic)');
				'c': launchExt('ALYX_ENV', 'nativeIDE','');
				'r': begin 	{ run a shell command }
					write('enter command:');
					readln(pathname);
					fpsystem(pathname);
				end;
				'w': launchExt('ALYX_ENV', 'browser', '');	
				'g': begin	{ could replace with cURL or define in reg }
					write('URL to grab: ');
					readln(pathname);
					fpsystem('wget ' + pathname);
				end;			
				'?': writeln('? prints man page');
				'h': writeln('h also prints man page');
				'a': aboutBox;
				'q': begin
					writeln('q exits to system shell'); 
					escToShell := true;
					end;
			else
				writeln('Unfamiliar command.');
			end;
		until escToShell = true;
	end.
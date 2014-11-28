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
	
{$H+}	{ stfu about ansistrings in fpsystem }	
program lash;	

uses Unix;

	var
		menuCmd: char;
		pathname: string; 	{ 	file pathname. Uses Unix syntax, not Lisa (too obscure
								and too much of a pain in the ass to translate). }
		escToShell: boolean; 
	
	procedure aboutBox;
		begin
			writeln('lash is the Lisaesque App Shell');
			writeln('very loosely based on Apple''s Lisa Workshop');
			writeln('©2014 Brian Connors. Part of the ALyX project.');
			writeln('licensed under the 3-clause BSD license');
			fpSystem('uname -v');
		end; 
	
	{ procedure makeImage -- creates a disk image isoOut from a specified directory path
		requires mkisofs to be installed; resulting image is ISO 9660-Joliet }
		
	procedure makeImage(path, isoOut, vname: string);
		begin
			fpSystem('mkisofs -r -J -o ' + isoOut + ' -V ' + vname + ' ' +path);
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
				
				'm': writeln('m invokes mv');
				'r': writeln('r deletes a file (y/n?)');
				
				'p': begin 		{ set-Path (aka cd) }
					write('change to: ');
					readln(pathname);
					chdir(pathname);
					if IOResult <> 0 then writeln('Invalid folder: ',pathname);
				end;
				'l': fpsystem('ls -l');
				'b': writeln('b backs up your working environment (pathname defined in ~/.lashrc)');
				'c': writeln('c copies a file');
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
				'c': fpsystem('bash'); 
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
		
		repeat 
			writeln('File-mgr, Sysutils, Edit, Debug, Pascal, Basic, C, Web browser, ?Help, Run shell-cmd, Quit?');
			readln(menuCmd);
			case menuCmd of
				'f': fileMenu;
				's': sysMenu;
				'e': writeln('e invokes editor (default nano)');
				'd': writeln('d invokes debugger (default gdb)');
				'p': writeln('p invokes Pascal IDE (default fpc IDE)');
				'b': writeln('b invokes Basic interpreter (default Chipmunk Basic)');
				'c': writeln('c invokes native IDE (Xcode on OS X, CodeBlocks on Linux, VSX on Windows) via shell script');
				'r': writeln('r asks for and runs a shell command');
				'w': writeln('w runs a web browser')
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

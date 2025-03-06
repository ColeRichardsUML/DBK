# DB_killer
 DropBox external backup drive safety script.

 A simple script that checks if a determined drive (the DRIVE) is connected and kills a determined process (the PROCESS) if not. If DRIVE is connected it will try to start the PROCESS if it isn't already running. Specifically, THE DRIVE for this version is the Dropbox backup drive and the PROCESS is Dropbox. The script exists to ensure that Dropbox doesn't start deleting items in the case that the DRIVE is unexpectedly disconnected. 
# DB_killer
 DropBox external backup drive safety script.

 A simple script that checks if a determined drive (the DRIVE) is connected and kills a determined process (the PROCESS) if not. If DRIVE is connected it will try to start the PROCESS if it isn't already running. Specifically, THE DRIVE for this version is the Dropbox backup drive and the PROCESS is Dropbox. The script exists to ensure that Dropbox doesn't start deleting items in the case that the DRIVE is unexpectedly disconnected. 

---TODO:---
- create a notification system (via email/push?) for IT
	- notification SFX
		- https://stackoverflow.com/questions/56032478
- add more information for potentially necessary debug reasons
- ~~direct interaction with Dropbox
	- notify when syncing is finshed~~
- general cleanup and refacturing
	- functions
add an optional GUI wrapper
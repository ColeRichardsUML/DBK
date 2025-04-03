# DBK
 DropBox external backup drive safety script.

 A simple script that checks if a determined drive (the DRIVE) is connected and kills a determined process (the PROCESS) if not. If DRIVE is connected it will try to start the PROCESS if it isn't already running. Specifically, THE DRIVE for this version is the Dropbox backup drive and the PROCESS is Dropbox. The script exists to ensure that Dropbox doesn't start deleting items in the case that the DRIVE is unexpectedly disconnected. 

 I had read that USB tends to have stability/connectivity issues. I had also read that should a drive that DropBox files are stored on be disconnected, DropBox may see that as a mass delete of those files and start deleting them from the DropBox Cloud. My limited testing says that the DropBox program is smarter than that, however I trust no one. Given that our DropBox files are backed up to a USB-connected drive rack, I figured I should make this script to be run while I run the backupevery week... just in case. 

## TODO:
 - create a notification system (via email/push?) for IT
	- notification SFX
		- https://stackoverflow.com/questions/56032478
 - add more information for potentially necessary debug reasons
 - ~~direct interaction with Dropbox~~ 
	- ~~notify when syncing is finshed~~
	- Not technically possible: https://stackoverflow.com/questions/20060354/how-do-i-check-the-sync-status-of-a-dropbox-account-using-the-api
 - ~~general cleanup and refacturing~~
	- ~~functions~~
 - add an optional GUI wrapper
 - add installer and shortcuts to make program easier to use
 - add auto update
 - conversion to executable program

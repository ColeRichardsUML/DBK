<#
.NOTES
    Author      : Colman Richards @Diversified-Colman-Richards
    GitHub      : https://github.com/Diversified-Colman-Richards/DB_killer
    Version     : 1.2
#>

param (
	# location you would like to save the process log to
	[string]$log_path = "$env:USERPROFILE\Desktop\DBK",
	[string]$log_name = (Get-Date).toString("yyyy-MM-dd HH-mm-ss") + " DBK_log.log",
	# the letter of the drive that you want to check if connected
	[char]$DRIVE = 'D',
	# The process that needs to be killed/started. 
	[string]$p_exe = "Dropbox.exe",
	[string]$p_name = "Dropbox",
	[string]$p_path = "C:\Program Files (x86)\Dropbox\Client",
	# time per loop of script in seconds
	[int]$tpl = 10
)

# import functions
$files = Get-ChildItem -Path .\functions
foreach ($file in $files) { . $file }

DBK_drive_check
DBK_prog_check
DBK_prog_start
DBK_prog_kill -p_name $p_name <# -tickrate $tpl #>

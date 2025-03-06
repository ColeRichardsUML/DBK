# ---DOCUMENTATION---
# Script Name: 	DB_killer
# Programmer: 	Colman Richards under Diversified Site Services LLC
# Date Created:	Thursday, February 13th, 2025
# Release:		v1.1 3/6/25
# View README.md for more info.

# ---TODO:---
# create a notification system (via email/push?) for IT
#	- notification SFX
#		- https://stackoverflow.com/questions/56032478
# add more information for potentially necessary debug reasons
# direct interaction with Dropbox
#	- notify when syncing is finshed
# general cleanup and refacturing



# ---PARAMETERS---
# ./DB_killer 


Param (
	# location you would like to save the process log to
	[string]$log_path = "$env:USERPROFILE\Desktop\Powershell Logs\DB_killer",
	[string]$log_name = (Get-Date).toString("yyyy-MM-dd HH-mm-ss") + " DB_killer log.log",
	# the letter of the drive that you want to check if connected
	[char]$DRIVE = 'D',
	# The process that needs to be killed/started. 
	[string]$p_exe = "Dropbox.exe",
	[string]$p_name = "Dropbox",
	[string]$p_path = "C:\Program Files (x86)\Dropbox\Client",
	# ticks per loop, time per loop of script in seconds
	[int]$tpl = 10
)

# ---VARIABLES---
# number of times script has attepted to start/kill the process in the current loop
$sk_attempts = 0
# number of times the DRIVE has been connected while script is running
# $dr_cons
# number of times DRIVE has disconnected while script is running
# $dr_discons
# time to sleep between loops determined by subtracting sk_attempts from tpl
$sleep_timer = $tpl - $sk_attempts

# ---MESSAGES AND STRINGS---
# these mostly exist to make the code more legible. They shouldn't need to be changed.
# startup message
$op_str = "Beginning monitoring and logging..."
# DRIVE connected = true, process running = false
$dt_pf = "The $DRIVE DRIVE is detected but $p_name is not running. Attempting start..."
# DRIVE connected = true, process running = true
$dt_pt = "The $DRIVE DRIVE is detected and $p_name is running."
# DRIVE connected = false, process running = true
$df_pt = "The $DRIVE DRIVE is not detected but $p_name is still running. Attempting termination..."
# DRIVE connected = false, process running = false
$df_pf = "The $DRIVE DRIVE is not detected and $p_name is not running."
# PROCESS start error message
$p_start_err = "ERROR: UNABLE TO START PROGRAM!"
# PROCESS kill error message
$p_kill_err = "ERROR: UNABLE TO KILL PROCESS!"
# time variable used to print the time to the log/console
$time = (Get-Date).toString("yyyy/MM/dd HH:mm:ss") # init to startup time

# ---SCRIPT START---
# start logging
Start-Transcript -Path $log_path\$log_name
# send start notification to IT here
Write-Host "$time $op_str"

while (1) { # run forever
	$time = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
	
	# check if the DRIVE is connected and act accordingly
	if (Get-PSDrive $DRIVE -ErrorAction SilentlyContinue) {
		
		$p = Get-Process $p_name -ea SilentlyContinue
		
		# if the process is not running yet, start it 
		if (!$p) { # do not duplicate process
			Write-Host "$time UH OH! $dt_pf"
			Start-Process -FilePath $p_exe -WorkingDirectory $p_path
			$sk_attempts = $sk_attempts + 1
			Start-sleep -Seconds 1
			
			# make sure PROCESS is started, send error if unable to start by end of loop
			$p = Get-Process -Name $p_name -ea SilentlyContinue			
			while (!$p -and $sk_attempts -lt $tpl) {
				Start-Process -FilePath $p_exe -WorkingDirectory $p_path
				$sk_attempts = $sk_attempts + 1
				Start-sleep -Seconds 1
				
				$p = Get-Process -Name $p_name -ea SilentlyContinue
				if (!$p -and $sk_attempts -ge $tpl) {
					$time = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
					Write-Host "$time $p_start_err"
					$wshell = New-Object -ComObject Wscript.Shell
					$wshell.Popup($p_start_err)
				}
			}
			
			if ($p) {
				$time = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
				Write-Host "$time ALL GOOD! $p_name has been successfully started!"
			}
			
			
			
		} else {
			Write-Host "$time ALL GOOD! $dt_pt"
		}
		
	} else { # Drive disconnect -> end services/processs
		
		$p = Get-Process -Name $p_name -ea SilentlyContinue
		
		# if the process is still running, close it
		if ($p) {
			Write-Host "$time UH OH! $df_pt"
			Stop-Process -Name $p_name -ea SilentlyContinue
			$sk_attempts = $sk_attempts + 1
			Start-sleep -Seconds 1
			
			# make sure the PROCESS is killed, send error if unable to kill by end of script loop
			$p = Get-Process -Name $p_name -ea SilentlyContinue
			while ($p -and $sk_attempts -lt $tpl) {
				Stop-Process -Name $p_name -ea SilentlyContinue
				$sk_attempts = $sk_attempts + 1
				Start-sleep -Seconds 1
				$p = Get-Process -Name $p_name -ea SilentlyContinue
				if ($p -and $sk_attempts -ge $tpl) {
					$time = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
					Write-Host "$time $p_kill_err"
					$wshell = New-Object -ComObject Wscript.Shell
					$wshell.Popup($p_kill_err)
				}
			}
			
			if (!$p) {
				$time = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
				Write-Host "$time ALL GOOD! $p_name has been terminated."
			}
			
		} else {
			Write-Host "$time ALL GOOD! $df_pf"
		}
	}
	# sleep gap between loops
	$sleep_timer = $tpl - $sk_attempts
	Start-sleep -Seconds $sleep_timer
	$sk_attempts = 0 # reset start/kill attempts
}
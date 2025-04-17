<#
.NOTES
    Author      : Colman Richards @Diversified-Colman-Richards
    GitHub      : https://github.com/Diversified-Colman-Richards/DB_killer
    Version     : 1.2
#>

param (
	[string] $config_file = "DBK_config.xml",
	[switch] $Debug
)


<# STARTUP ROUTINE #>
# Set DebugPreference based on -debug switch
if ($Debug) { $DebugPreference = "Continue" }

# Load configuration file (DBK_config.xml)
$config = ([xml](Get-Content $config_file)).root

# Start logging


# Import functions
$files = Get-ChildItem -Path .\functions
foreach ($file in $files) { . $file }


# ./DBK_main.ps1
$end = $false
Do {
	if (DBK_drive_is_connected) {
		DBK_proc_start
	} else {
		DBK_proc_kill
	}
	Start-Sleep -Seconds $config.tickrate
} Until ($end)

Write-Debug "Running DBK_startup_routine"

<# STARTUP ROUTINE #>

# Start log
Start-Transcript -Path $log_path\$log_name

# Set DebugPreference based on -debug switch
if ($Debug) {
	$DebugPreference = "Continue"
}

# Load Interface (FOR FUTURE RELEASE)

# Load configuration file (DBK_config.xml)
$config = ([xml](Get-Content $config_file)).root

<# # Load DLLs
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms #>

# Import functions
$files = Get-ChildItem -Path .\functions
foreach ($file in $files) { . $file }

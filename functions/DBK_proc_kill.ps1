function DBK_proc_kill {

    param (
        # Number of attempts that have been made to end the process.
        [parameter(Position = 0)][int] $attempts = 0
    )

    if (DBK_proc_is_running) {
        $attempts++
        if ($attempts -eq 1) {
            Write-Host ("Attempting to terminate " + $config.process.name + '.')
        }
        Stop-Process -Name $config.process.name -ea SilentlyContinue

        # DELETE THIS (Testing purposes only.)
        <# if ($attempts -lt 25) {
            Start-Process -FilePath $config.process.exe -WorkingDirectory $config.process.path
        } #>

        # Check if successful, try again if not.
        DBK_proc_kill $attempts
        
    } elseif ($attempts -eq 0) {
        Write-Host ($config.process.name + " is not running.")
    } elseif ($attempts -eq 1) {
        Write-Host ($config.process.name + " was terminated after 1 attempt.")
    } elseif ($attempts -gt 1) {
        Write-Host ($config.process.name + " was terminated after " + $attempts + " attempts")
    } else {
        Write-Debug "DBK_proc_kill ERROR: Unexpexted conditional."
    }

}

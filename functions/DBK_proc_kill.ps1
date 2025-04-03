function DBK_proc_kill {

    param (
        # Number of attempts that have been made to end the process.
        [parameter(Position = 0)][int] $attempts = 0
    )

    DBK_dt_writer -wd "DBK_proc_kill has been called."

    if (DBK_proc_is_running) {
        $attempts++
        if ($attempts -eq 1) {
            DBK_dt_writer -wh ("Attempting to terminate " + $config.process.name + '.')
        }
        Stop-Process -Name $config.process.name -ea SilentlyContinue

        # DELETE THIS (Testing purposes only.)
        <# if ($attempts -lt 25) {
            Start-Process -FilePath $config.process.exe -WorkingDirectory $config.process.path
        } #>

        # Check if successful, try again if not.
        Start-Sleep -Milliseconds 300 

        DBK_proc_kill $attempts
        
    } elseif ($attempts -eq 0) {
        DBK_dt_writer -wh ($config.process.name + " is not running.")
    } elseif ($attempts -eq 1) {
        DBK_dt_writer -wh ($config.process.name + " was terminated after 1 attempt.")
    } elseif ($attempts -gt 1) {
        DBK_dt_writer -wh ($config.process.name + " was terminated after " + $attempts + " attempts")
    } else {
        DBK_dt_writer -wd "DBK_proc_kill ERROR: Unexpexted conditional."
    }

}

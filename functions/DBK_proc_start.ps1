function DBK_proc_start {
    param(
        
    )

    Write-Debug "DBK_proc_start has been called."

    if (DBK_proc_is_running) {
        Write-Debug ($config.process.exe + " is already running.")
    } else {
        Write-Host ("Starting " + $config.process.exe + "...")
        Start-Process -FilePath $config.process.exe -WorkingDirectory $config.process.path
    }

    return DBK_proc_is_running

}

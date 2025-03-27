function DBK_proc_is_running {
    param(
        
    )

    Write-Debug "DBK_proc_is_running has been called."

    if (Get-Process $config.process.name -ea SilentlyContinue) {
        return $true
    } else {
        return $false
    }
}
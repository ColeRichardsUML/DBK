function DBK_proc_is_running {
    param(
        
    )

    if (Get-Process $config.process.name -ea SilentlyContinue) {
        return $true
    } else {
        return $false
    }
}
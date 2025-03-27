function DBK_drive_is_connected {
    param(

    )

    Write-Debug "DBK_drive_is_connected has been called."

    if (Get-PSDrive $config.drive -ea SilentlyContinue) {
        return $true
    } else {
        return $false
    }
}
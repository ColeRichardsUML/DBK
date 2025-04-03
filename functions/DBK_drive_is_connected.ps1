function DBK_drive_is_connected {
    param(

    )

    if (Get-PSDrive $config.drive -ea SilentlyContinue) {
        return $true
    } else {
        return $false
    }
}
function DBK_dt_writer {
    param (
        # string message that user would like to send
        [Parameter(Mandatory)][string] $message,

        # switches to determine where to send the message
        [parameter(Mandatory, parameterSetName = 'destination')]$wh,    # Write-Host
        [parameter(Mandatory, parameterSetName = 'destination')]$wd,    # Write-Debug
        [parameter(Mandatory, parameterSetName = 'destination')]$we,    # Write-Error
        [parameter(Mandatory, parameterSetName = 'destination')]$wo     # Write-Output
    )
    
    

}
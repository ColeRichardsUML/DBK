<# 
.NOTES
    DBK_dt_writer

    Writes a given message to a given location lead with a date-and-time stamp.
#>
function DBK_dt_writer {

    param (
        # Location that user would like to send the message to.
        [Parameter(Position = 0, Mandatory = $true, 
        ParameterSetName = "Write-Host")]
        [switch]$wh,
        [Parameter(Position = 0, Mandatory = $true, 
        ParameterSetName = "Write-Debug")]
        [switch]$wd,
        [Parameter(Position = 0, Mandatory = $true, 
        ParameterSetName = "Write-Error")]
        [switch]$we,
        [Parameter(Position = 0, Mandatory = $true, 
        ParameterSetName = "Write-Output")]
        [switch]$wo,

        # String message that user would like to send.
        [Parameter(Position = 1, Mandatory = $true)][string] $message
    )

    # Write-Debug "DBK_dt_writer has been called." # FOR TESTING
    
    $dt = Get-Date -Format "yyyy/MM/dd HH:mm:ss - "

    if ($wh) { Write-Host    ($dt + $message) }
    if ($wd) { Write-Debug   ($dt + $message) }
    if ($we) { Write-Error   ($dt + $message) }
    if ($wo) { Write-Output  ($dt + $message) }

}

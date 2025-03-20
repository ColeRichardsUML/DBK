function DBK_prog_kill {
    param (
        [parameter(Mandatory = $true, 
        ParameterSetName = "with_name")]
        [string]$p_name,

        [parameter(Mandatory = $true, 
        ParameterSetName = "with_id")]
        [int32]$p_id,

        [parameter(Mandatory = $true)]
        [int]$tr,
        
        [int]$attempt = 1
    )

    if ($attempt -ge $tr) {
        throw 
    } elseif ($p_name) {    #with_name
        Stop-Process -Name $p_name -ea SilentlyContinue
    } elseif ($p_id) {      # with_id
        Stop-Process -Id $p_id -ea SilentlyContinue
    }

}

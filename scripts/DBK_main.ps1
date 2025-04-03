Write-Debug "Running DBK_main"
$end = $false
Do {
	if (DBK_drive_is_connected) {
		DBK_proc_start
	} else {
		DBK_proc_kill
	}
	Start-Sleep -Seconds $tr
} Until ($end)

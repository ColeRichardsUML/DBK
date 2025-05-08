<# 
.NOTES
    Provides a Graphical User Interface for the program.
#>

Add-Type -assembly System.Windows.Forms

$DBK_GUI = New-Object System.Windows.Forms.Form
$DBK_GUI.Text = "DBK"
$DBK_GUI.ClientSize = "Auto" , "Auto"

<# 
.NAME
    VMWare ESXi Auto Snapshot Reverter
.SYNOPSIS
    Create VMWare VM's quickly and easily with this great GUI
.DESCRIPTION
    Create VMWare VM's quickly and easily with this great GUI
#>

<#
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$SnapShotReverter = New-Object System.Windows.Forms.Form
$SnapShotReverter.ClientSize = New-Object System.Drawing.Point(645, 727)
$SnapShotReverter.text = "AutoSnapshot Reverter v2.0 BETA"
$SnapShotReverter.TopMost = $false

$UserNameTextBox                 = New-Object system.Windows.Forms.TextBox
$UserNameTextBox.multiline       = $false
$UserNameTextBox.text            = "esxi_username"
$UserNameTextBox.width           = 180
$UserNameTextBox.height          = 20
$UserNameTextBox.location        = New-Object System.Drawing.Point(100,20)
$UserNameTextBox.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ServerTextBox                   = New-Object system.Windows.Forms.TextBox
$ServerTextBox.multiline         = $false
$ServerTextBox.text              = "192.168.1.254"
$ServerTextBox.width             = 238
$ServerTextBox.height            = 20
$ServerTextBox.location          = New-Object System.Drawing.Point(380,20)
$ServerTextBox.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$PasswordTextBox                 = New-Object system.Windows.Forms.MaskedTextBox
$PasswordTextBox.multiline       = $false
$PasswordTextBox.width           = 180
$PasswordTextBox.height          = 20
$PasswordTextBox.location        = New-Object System.Drawing.Point(100,50)
$PasswordTextBox.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$PasswordTextBox.PasswordChar = '*'

$ConnectButton                   = New-Object system.Windows.Forms.Button
$ConnectButton.text              = "Connect to VMware ESXi Server"
$ConnectButton.width             = 297
$ConnectButton.height            = 32
$ConnectButton.location          = New-Object System.Drawing.Point(321,48)
$ConnectButton.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$VMHostComboBox                  = New-Object system.Windows.Forms.ComboBox
$VMHostComboBox.text             = "Please connect first to populate list"
$VMHostComboBox.width            = 370
$VMHostComboBox.height           = 20
$VMHostComboBox.location         = New-Object System.Drawing.Point(250,140)
$VMHostComboBox.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SnapShotReverter.controls.AddRange(@($UserNameTextBox,$ServerTextBox,$ConnectButton,$PasswordTextBox,$VMHostComboBox))

$ConnectButton.Add_Click({ ConnectNow })

function ConnectNow
{
    $ConnectVI = Connect-VIServer -Server $ServerTextBox.Text -user $UserNameTextBox.Text -password $PasswordTextBox.Text -ErrorAction SilentlyContinue -ErrorVariable Err
    if($Err.Count -gt 0)
    {
        Write-Host "Incorrect username or password"
    }
    Else
    {
        Write-Host "Successfully Connected to VMWare ESXi Console"
        $VMList = Get-VM | Get-Snapshot | sort-object | select name -Unique
        foreach($VM in $VMList.Name)
        {
            $VMHostComboBox.Items.Add($VM)
        }
        $VMHostComboBox.Text ="Select a VM from this dropdown list"
        $VMHostComboBox.BackColor = 'pink'
    }
}

$PowerCLISet = Set-PowerCLIConfiguration -ProxyPolicy NoProxy -InvalidCertificateAction Ignore -Confirm:$false -DefaultVIServerMode Multiple -Scope User

#endregion
[void]$SnapShotReverter.ShowDialog()
#>
<# 
.NAME
    test
#>


#region Form design
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$AutoSnapReverter                = New-Object system.Windows.Forms.Form
$AutoSnapReverter.ClientSize     = New-Object System.Drawing.Point(675,467)
$AutoSnapReverter.text           = "Auto Snapshot Reverter v2.0"
$AutoSnapReverter.TopMost        = $false
$AutoSnapReverter.BackColor      = [System.Drawing.ColorTranslator]::FromHtml("#f4f4f4")

$BannerPanel2                    = New-Object system.Windows.Forms.Panel
$BannerPanel2.height             = 69
$BannerPanel2.width              = 500
$BannerPanel2.location           = New-Object System.Drawing.Point(216,-1)
$BannerPanel2.BackColor          = [System.Drawing.ColorTranslator]::FromHtml("#35ad94")

$BackPanel                       = New-Object system.Windows.Forms.Panel
$BackPanel.height                = 468
$BackPanel.width                 = 220
$BackPanel.location              = New-Object System.Drawing.Point(-4,0)
$BackPanel.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#47445d")

$BannerPanel1                    = New-Object system.Windows.Forms.Panel
$BannerPanel1.height             = 69
$BannerPanel1.width              = 300
$BannerPanel1.location           = New-Object System.Drawing.Point(-4,-1)
$BannerPanel1.BackColor          = [System.Drawing.ColorTranslator]::FromHtml("#287a69")

$ConnectionPanelLabel            = New-Object system.Windows.Forms.Label
$ConnectionPanelLabel.text       = "Connection Panel"
$ConnectionPanelLabel.AutoSize   = $true
$ConnectionPanelLabel.width      = 25
$ConnectionPanelLabel.height     = 10
$ConnectionPanelLabel.location   = New-Object System.Drawing.Point(40,25)
$ConnectionPanelLabel.Font       = New-Object System.Drawing.Font('Segoe UI Symbol',14)
$ConnectionPanelLabel.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$TitleLabel                      = New-Object system.Windows.Forms.Label
$TitleLabel.text                 = "Auto Snapshot Reverter v2.0"
$TitleLabel.AutoSize             = $true
$TitleLabel.width                = 25
$TitleLabel.height               = 10
$TitleLabel.location             = New-Object System.Drawing.Point(86,20)
$TitleLabel.Font                 = New-Object System.Drawing.Font('Segoe UI Symbol',18)
$TitleLabel.ForeColor            = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$ServerLabel                     = New-Object system.Windows.Forms.Label
$ServerLabel.text                = "ESXi Server IP"
$ServerLabel.AutoSize            = $true
$ServerLabel.width               = 25
$ServerLabel.height              = 10
$ServerLabel.location            = New-Object System.Drawing.Point(27,91)
$ServerLabel.Font                = New-Object System.Drawing.Font('Segoe UI Symbol',12)
$ServerLabel.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$UserLabel                       = New-Object system.Windows.Forms.Label
$UserLabel.text                  = "Username"
$UserLabel.AutoSize              = $true
$UserLabel.width                 = 25
$UserLabel.height                = 10
$UserLabel.location              = New-Object System.Drawing.Point(27,150)
$UserLabel.Font                  = New-Object System.Drawing.Font('Segoe UI Symbol',12)
$UserLabel.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$PassLabel                       = New-Object system.Windows.Forms.Label
$PassLabel.text                  = "Password"
$PassLabel.AutoSize              = $true
$PassLabel.width                 = 25
$PassLabel.height                = 10
$PassLabel.location              = New-Object System.Drawing.Point(27,209)
$PassLabel.Font                  = New-Object System.Drawing.Font('Segoe UI Symbol',12)
$PassLabel.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$ServerBox                       = New-Object system.Windows.Forms.TextBox
$ServerBox.multiline             = $false
$ServerBox.width                 = 180
$ServerBox.height                = 20
$ServerBox.text                  = "192.168.1.254"
$ServerBox.location              = New-Object System.Drawing.Point(27,120)
$ServerBox.Font                  = New-Object System.Drawing.Font('Segoe UI Symbol',10)
$ServerBox.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$ServerBox.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$UserBox                       = New-Object system.Windows.Forms.TextBox
$UserBox.multiline             = $false
$UserBox.width                 = 180
$UserBox.height                = 20
$UserBox.text                  = "root"
$UserBox.location              = New-Object System.Drawing.Point(27,180)
$UserBox.Font                  = New-Object System.Drawing.Font('Segoe UI Symbol',10)
$UserBox.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$UserBox.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$PasswordBox                     = New-Object system.Windows.Forms.MaskedTextBox
$PasswordBox.multiline           = $false
$PasswordBox.width               = 180
$PasswordBox.height              = 20
$PasswordBox.location            = New-Object System.Drawing.Point(27,239)
$PasswordBox.Font                = New-Object System.Drawing.Font('Segoe UI Symbol',10)
$PasswordBox.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$PasswordBox.PasswordChar = '*'

$ConnectBtn                      = New-Object system.Windows.Forms.Button
$ConnectBtn.text                 = "CONNECT"
$ConnectBtn.width                = 193
$ConnectBtn.height               = 58
$ConnectBtn.location             = New-Object System.Drawing.Point(15,391)
$ConnectBtn.Font                 = New-Object System.Drawing.Font('Segoe UI Symbol',12)
$ConnectBtn.FlatStyle            = [System.Windows.Forms.FlatStyle]::Flat
$ConnectBtn.FlatAppearance.BorderColor = [System.Drawing.ColorTranslator]::FromHtml("#49c8aa")
$ConnectBtn.ForeColor            = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$ConnectBtn.BackColor            = [System.Drawing.ColorTranslator]::FromHtml("#49c8aa")

$StatusLabel                     = New-Object system.Windows.Forms.Label
$StatusLabel.text                = "Status:"
$StatusLabel.AutoSize            = $true
$StatusLabel.width               = 25
$StatusLabel.height              = 10
$StatusLabel.location            = New-Object System.Drawing.Point(240,72)
$StatusLabel.Font                = New-Object System.Drawing.Font('Segoe UI Symbol',14)

$ConnectStatusLabel              = New-Object system.Windows.Forms.Label
$ConnectStatusLabel.text         = "Please Connect to ESXi Server"
$ConnectStatusLabel.AutoSize     = $true
$ConnectStatusLabel.width        = 25
$ConnectStatusLabel.height       = 10
$ConnectStatusLabel.location     = New-Object System.Drawing.Point(302,72)
$ConnectStatusLabel.Font         = New-Object System.Drawing.Font('Segoe UI Symbol',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$ConnectStatusLabel.BackColor    = [System.Drawing.ColorTranslator]::FromHtml("#f494b5")

$VMLabel                         = New-Object system.Windows.Forms.Label
$VMLabel.text                    = "List of Virtual Machines:"
$VMLabel.AutoSize                = $true
$VMLabel.width                   = 25
$VMLabel.height                  = 10
$VMLabel.location                = New-Object System.Drawing.Point(240,110)
$VMLabel.Font                    = New-Object System.Drawing.Font('Segoe UI Symbol',14)

$VMListBox                       = New-Object system.Windows.Forms.ListBox
$VMListBox.text                  = "listBox"
$VMListBox.width                 = 418
$VMListBox.height                = 133
$VMListBox.SelectionMode         = 'MultiExtended'
$VMListBox.location              = New-Object System.Drawing.Point(240,145)
$VMListBox.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$SnapshotLabel                   = New-Object system.Windows.Forms.Label
$SnapshotLabel.text              = "Available Snapshots:"
$SnapshotLabel.AutoSize          = $true
$SnapshotLabel.width             = 25
$SnapshotLabel.height            = 10
$SnapshotLabel.location          = New-Object System.Drawing.Point(240,280)
$SnapshotLabel.Font              = New-Object System.Drawing.Font('Segoe UI Symbol',14)

$SnapshotCombo                   = New-Object system.Windows.Forms.ComboBox
$SnapshotCombo.text              = "Please Connect First to Populate List"
$SnapshotCombo.width             = 398
$SnapshotCombo.height            = 20
$SnapshotCombo.location          = New-Object System.Drawing.Point(240,316)
$SnapshotCombo.Font              = New-Object System.Drawing.Font('Segoe UI Symbol',12)

$RevertBtn                       = New-Object system.Windows.Forms.Button
$RevertBtn.text                  = "REVERT"
$RevertBtn.width                 = 196
$RevertBtn.height                = 57
$RevertBtn.location              = New-Object System.Drawing.Point(252,391)
$RevertBtn.Font                  = New-Object System.Drawing.Font('Segoe UI Symbol',14)
$RevertBtn.FlatStyle            = [System.Windows.Forms.FlatStyle]::Flat
$RevertBtn.FlatAppearance.BorderColor = [System.Drawing.ColorTranslator]::FromHtml("#43b9a0")
$RevertBtn.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$RevertBtn.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#43b9a0")

$AbortBtn                        = New-Object system.Windows.Forms.Button
$AbortBtn.text                   = "ABORT"
$AbortBtn.width                  = 196
$AbortBtn.height                 = 57
$AbortBtn.location               = New-Object System.Drawing.Point(458,391)
$AbortBtn.Font                   = New-Object System.Drawing.Font('Segoe UI Symbol',14)
$AbortBtn.FlatStyle            = [System.Windows.Forms.FlatStyle]::Flat
$AbortBtn.FlatAppearance.BorderColor = [System.Drawing.ColorTranslator]::FromHtml("#b1d453")
$AbortBtn.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$AbortBtn.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#b1d453")

$AutoSnapReverter.controls.AddRange(@($BannerPanel2,$BackPanel,$StatusLabel,$ConnectStatusLabel,$VMLabel,$VMListBox,$SnapshotLabel,$SnapshotCombo,$RevertBtn,$AbortBtn))
$BackPanel.controls.AddRange(@($BannerPanel1,$ServerLabel,$UserLabel,$PassLabel,$ServerBox,$UserBox,$PasswordBox,$ConnectBtn))
$BannerPanel1.controls.AddRange(@($ConnectionPanelLabel))
$BannerPanel2.controls.AddRange(@($TitleLabel))

#endregion

#region Logic

# Handle connect button click
$ConnectBtn.Add_Click({ ConnectToServer })

function ConnectToServer {
    $ConnectStatusLabel.Text = "Please wait, connecting to ESXi Server"
    $ConnectCLI = Connect-VIServer -Server $ServerBox.Text -User $UserBox.Text -Password $PasswordBox.Text -ErrorAction SilentlyContinue -ErrorVariable Err
    if($Err.Count -gt 0)
    {
        $ConnectStatusLabel.Text = "Incorrect user name or password!"
    }
    Else
    {
        $ConnectStatusLabel.Text = "Connected to ESXi Server!"
        $ConnectStatusLabel.BackColor = "#b8e986"

        # Populate the VM listbox
        # $VMList = Get-VM | Get-Snapshot | sort-object | select name -Unique
        $VMList = Get-VM | sort | select name -Unique
        foreach($VM in $VMList.Name)
        {
            $VMListBox.Items.Add($VM)
        }

        # Populate the Snapshot combobox
        $Snapshots = Get-VM | Get-Snapshot | sort | select name -Unique
        foreach($Snapshot in $Snapshots.Name)
        {
            $SnapshotCombo.Items.Add($Snapshot)
        }
        $SnapshotCombo.Text = "Select a Snapshot from this dropdown"
        $SnapshotCombo.BackColor='pink'
    }
}

# Handle abort button click
$AbortBtn.Add_Click({ Abort })

function Abort {
    Write-Host "Aborted! Good bye~"
    $AutoSnapReverter.Close()
}

# Handle Revert button click
$RevertBtn.Add_Click({ Revert })

function Revert {
    $SnapshotName = $SnapshotCombo.Text
    Write-Host $SnapshotName
    
    foreach($VM in $VMListBox.SelectedItems) {
        Write-Host $VM -ForegroundColor Cyan
        Get-Snapshot -VM $VM -Name $SnapshotName -ErrorAction SilentlyContinue -ErrorVariable Err | Foreach-Object {Set-VM -VM $_.VM -Snapshot $_ -Confirm:$true}
        if($Err -gt 0) {
            Write-Color "⚠️ [ERROR] The snapshot ", $SnapshotName, "could not be found for ", "$_.VM, skipping..." -Color Red, Yellow, Red, Cyan
        }
        Else {
            Write-Color "Sucessfully Reverted ", $VM, " to: ", $SnapshotName -Color Green, Yellow, Magenta
        }
        <#if(Get-Snapshot -VM $item -Name $snapshotname | Foreach-Object {Set-VM -VM $_.VM -Snapshot $_ -Confirm:$true})
        {
            Write-Host "Reverted!" -ForegroundColor Green
        }
        else
        {
            Write-Color "[ERROR]The snapshot ", "$snapshotname ", "could not be found for ", "$_.VM" -Color Red, Yellow, Red, Cyan
        }#>
    }
    Write-Color -Text 'Successfully Reverted VM(s) to: ', $SnapshotName -Color Green, Magenta
}

# Attempt to import the VMware module
$VMWareImportFailed = $False
try {
    Import-Module VMware.DeployAutomation -ErrorAction Stop
}
catch {
    Write-Host "[Error] $($_.Exception.Message)" -ForegroundColor Red
    [System.Windows.MessageBox]::Show($_.Exception.Message)
    Write-Host "You must download and install VMWare PowerCLI v6.5 or above" -ForegroundColor Red
    [System.Windows.MessageBox]::Show("Please download and install VMWare PowerCLI v6.5 or above")
    $VMWareImportFailed = $True
    Break
}
# Set-up PowerCLI config for current session
if($VMWareImportFailed -eq $False)
{
    $PowerCLISet = Set-PowerCLIConfiguration -ProxyPolicy NoProxy -InvalidCertificateAction Ignore -Confirm:$False -DefaultVIServerMode Multiple -Scope User
}


#endregion

[void]$AutoSnapReverter.ShowDialog()
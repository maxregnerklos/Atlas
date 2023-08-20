# Credit to spddl for part of the code
# Require admin privileges if User Account Control (UAC) is enabled
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Start-Process PowerShell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

if not ctypes.windll.shell32.IsUserAnAdmin():
    ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 1)
    sys.exit()
 
import subprocess
import tkinter as tk
from tkinter import messagebox
 
def generate_checkbox(checkboxText, package, enabled=True):
    checkbox = tk.Checkbutton(
        form,
        text=checkboxText,
        variable=checkbox_vars[package],
        onvalue=1,
        offvalue=0,
        state="normal" if enabled else "disabled"
    )
    checkbox.pack()
    return checkbox
 
# Set the size of your form
form = tk.Tk()
form.title("Install Software | Atlas")
form.geometry("600x210")
form.resizable(False, False)
 
# Label
label = tk.Label(form, text="Download and install software using Chocolatey:")
label.pack()
 
# Checkbox variables
checkbox_vars = {}
 
# Generate checkboxes
checkbox_vars["googlechrome"] = tk.IntVar()
generate_checkbox("Google Chrome", "googlechrome")
 
checkbox_vars["firefox"] = tk.IntVar()
generate_checkbox("Mozilla Firefox", "firefox")
 
checkbox_vars["brave"] = tk.IntVar()
generate_checkbox("Brave Browser", "brave")
 
checkbox_vars["microsoft-edge"] = tk.IntVar()
generate_checkbox("Microsoft Edge", "microsoft-edge")
 
checkbox_vars["librewolf"] = tk.IntVar()
generate_checkbox("LibreWolf", "librewolf")
 
checkbox_vars["ungoogled-chromium"] = tk.IntVar()
generate_checkbox("ungoogled-chromium", "ungoogled-chromium")
 
checkbox_vars["discord"] = tk.IntVar()
generate_checkbox("Discord", "discord")
 
checkbox_vars["discord-canary"] = tk.IntVar()
generate_checkbox("Discord Canary", "discord-canary")
 
checkbox_vars["steam"] = tk.IntVar()
generate_checkbox("Steam", "steam")
 
checkbox_vars["playnite"] = tk.IntVar()
generate_checkbox("Playnite", "playnite")
 
checkbox_vars["rare"] = tk.IntVar()
generate_checkbox("Rare", "rare")
 
checkbox_vars["everything"] = tk.IntVar()
generate_checkbox("Everything", "everything")
 
checkbox_vars["thunderbird"] = tk.IntVar()
generate_checkbox("Mozilla Thunderbird", "thunderbird")
 
checkbox_vars["foobar2000"] = tk.IntVar()
generate_checkbox("foobar2000", "foobar2000")
 
checkbox_vars["irfanview"] = tk.IntVar()
generate_checkbox("IrfanView", "irfanview")
 
checkbox_vars["git"] = tk.IntVar()
generate_checkbox("Git", "git")
 
checkbox_vars["mpv"] = tk.IntVar()
generate_checkbox("mpv", "mpv")
 
checkbox_vars["vlc"] = tk.IntVar()
generate_checkbox("VLC", "vlc")
 
checkbox_vars["putty"] = tk.IntVar()
generate_checkbox("PuTTY", "putty")
 
checkbox_vars["teamspeak"] = tk.IntVar()
generate_checkbox("Teamspeak", "teamspeak")
 
checkbox_vars["spotify"] = tk.IntVar()
generate_checkbox("Spotify", "spotify")
 
checkbox_vars["obs-studio"] = tk.IntVar()
generate_checkbox("OBS Studio", "obs-studio")
 
checkbox_vars["msiafterburner"] = tk.IntVar()
generate_checkbox("MSI Afterburner", "msiafterburner")
 
checkbox_vars["cpu-z"] = tk.IntVar()
generate_checkbox("CPU-Z", "cpu-z")
 
checkbox_vars["gpu-z"] = tk.IntVar()
generate_checkbox("GPU-Z", "gpu-z")
 
checkbox_vars["notepadplusplus"] = tk.IntVar()
generate_checkbox("Notepad++", "notepadplusplus")
 
checkbox_vars["vscode"] = tk.IntVar()
generate_checkbox("VSCode", "vscode")
 
checkbox_vars["bulk-crap-uninstaller"] = tk.IntVar()
generate_checkbox("Bulk Crap Uninstaller", "bulk-crap-uninstaller")
 
checkbox_vars["hwinfo"]= tk.IntVar()
generate_checkbox("HWiNFO", "hwinfo")
 
checkbox_vars["kav"] = tk.IntVar()
generate_checkbox("Kaspersky Anti-Virus", "kav")
 
checkbox_vars["microsoft-windows-terminal"] = tk.IntVar()
generate_checkbox("Windows Terminal", "microsoft-windows-terminal")
 
checkbox_vars["waterfox"] = tk.IntVar()
generate_checkbox("Waterfox", "waterfox")
 
checkbox_vars["lightshot"] = tk.IntVar()
generate_checkbox("Lightshot", "lightshot")
 
# Install Button
def install_packages():
    checked_packages = [package for package, var in checkbox_vars.items() if var.get() == 1]
    if len(checked_packages) == 0:
        messagebox.showinfo("No package selected", "Please select at least one software package to install.")
    else:
        install_command = f"choco install {' '.join(checked_packages)} -y --force --allow-empty-checksums"
        subprocess.run(install_command, shell=True)
 
install_button = tk.Button(form, text="Install", command=install_packages)
install_button.pack()
 
# Activate the form
form.mainloop()
 
# Install selected packages
checked_packages = [package for package, var in checkbox_vars.items() if var.get() == 1]
if len(checked_packages) > 0:
    install_command = f"choco install {' '.join(checked_packages)} -y --force --allow-empty-checksums"
    subprocess.run(install_command, shell=True)

if ($global:column -ne 0) {
    $global:lastPos += $separate
}

$Form.height = $global:lastPos + 80

# Detect internet connection
$InternetTest = (Test-Connection -ComputerName www.google.com -Quiet)
if (!$InternetTest) {
    [System.Windows.Forms.MessageBox]::Show("Internet connection not detected. Please check your network connection and try again.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    exit
}

# Check if the system has dark mode or light mode set
$darkMode = Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" | Select-Object -ExpandProperty "AppsUseLightTheme"
if ($darkMode -eq 0) {
    $Form.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
    $Form.ForeColor = [System.Drawing.Color]::White
    foreach ($control in $Form.Controls) {
        if ($control.GetType().Name -eq "Checkbox") {
            $control.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
            $control.ForeColor = [System.Drawing.Color]::White
        }
    }
} else {
    $Form.BackColor = [System.Drawing.Color]::White
    $Form.ForeColor = [System.Drawing.Color]::Black
    foreach ($control in $Form.Controls) {
        if ($control.GetType().Name -eq "Checkbox") {
            $control.BackColor = [System.Drawing.Color]::White
            $control.ForeColor = [System.Drawing.Color]::Black
        }
    }
}

# Install Button
$lastPosWidth = $form.Width - 80 - 31
$InstallButton = new-object System.Windows.Forms.Button
$InstallButton.Location = new-object System.Drawing.Size($lastPosWidth, $global:lastPos)
$InstallButton.Size = new-object System.Drawing.Size(80, 23)
$InstallButton.Text = "Install"
$InstallButton.Add_Click({
    $checkedBoxes = $Form.Controls | Where-Object { $_ -is [System.Windows.Forms.Checkbox] -and $_.Checked }
    if ($checkedBoxes.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Please select at least one software package to install.", "No package selected", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
    else {
        $global:install = $true
        $Form.Close()
    }
})
$Form.Controls.Add($InstallButton)

# Activate the form
$Form.Add_Shown({ $Form.Activate() })
[void] $Form.ShowDialog()

if ($global:install) {
    $installPackages = [System.Collections.ArrayList]::new()
    $installSeparatedPackages = [System.Collections.ArrayList]::new()
    $Form.Controls | Where-Object { $_ -is [System.Windows.Forms.Checkbox] } | ForEach-Object {
        if ($_.Checked) {
            if ($_.Name.contains("--")) {
                [void]$installSeparatedPackages.Add($_.Name)
            }
            else {
                [void]$installPackages.Add($_.Name)
            }
        }
    }

    if ($installPackages.count -ne 0) {
        Write-Host "$Env:ProgramData\chocolatey\choco.exe install $($installPackages -join ' ') -y"
        Start-Process -FilePath "$Env:ProgramData\chocolatey\choco.exe" -ArgumentList "install $($installPackages -join ' ') -y --force --allow-empty-checksums" -Wait
    }
    if ($installSeparatedPackages.count -ne 0) {
        foreach ($paket in $installSeparatedPackages) {
            Write-Host "$Env:ProgramData\chocolatey\choco.exe install $paket -y"
            Start-Process -FilePath "$Env:ProgramData\chocolatey\choco.exe" -ArgumentList "install $paket -y --ignore-checksums" -Wait
            if ($paket.contains("--version")) {
                Write-Host "$Env:ProgramData\chocolatey\choco.exe pin add -n $($paket.split(' ')[0])"
                Start-Process -FilePath "$Env:ProgramData\chocolatey\choco.exe" -ArgumentList "pin add -n $($paket.split(' ')[0])" -Wait
            }
        }
    }
}

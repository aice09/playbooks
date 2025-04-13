# Install-XPVM.ps1
# Author: You
# Purpose: Fully unattended Windows XP VM setup in VirtualBox

$VMName = "XPVM01"
$ISOPath = "\\phl-vm-file01\corpfile\software\xp.iso"
$VFDPath = "C:\Install\winnt.vfd"
$VHDPath = "C:\VirtualBox VMs\$VMName\$VMName.vdi"
$SharedFolder = "C:\Shared"

# Create VM
VBoxManage createvm --name $VMName --ostype WindowsXP --register

# Modify VM settings
VBoxManage modifyvm $VMName --memory 512 --acpi on --ioapic on `
  --boot1 dvd --boot2 disk --nic1 nat `
  --clipboard bidirectional --draganddrop bidirectional

# Create virtual hard disk
VBoxManage createmedium disk --filename $VHDPath --size 10000 --format VDI

# Add IDE controller
VBoxManage storagectl $VMName --name "IDE Controller" --add ide

# Attach hard disk
VBoxManage storageattach $VMName --storagectl "IDE Controller" `
  --port 0 --device 0 --type hdd --medium $VHDPath

# Attach ISO
VBoxManage storageattach $VMName --storagectl "IDE Controller" `
  --port 1 --device 0 --type dvddrive --medium $ISOPath

# Attach Floppy Disk (winnt.sif inside)
VBoxManage setextradata $VMName "VBoxInternal/Devices/floppy/0/Config/Path" "$VFDPath"

# Add shared folder (optional)
VBoxManage sharedfolder add $VMName --name "Shared" --hostpath $SharedFolder --automount

# Start VM
VBoxManage startvm $VMName --type headless

Write-Host "`n[*] Windows XP VM '$VMName' installation started with ISO and VFD attached."

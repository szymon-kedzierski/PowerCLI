# Oneliner for getting VM ID 
# Input: vCenter IP, VM name
# Author: Szymon Kędzierski

[CmdletBinding()]
Param (

# vCenter IP
[Parameter (Mandatory=$True)] [string] $vc_IP,
[Parameter (Mandatory=$True)] [string] $vm_name

)

# Connect to the vCenter server(s) 
$vcserver = Connect-VIServer $vc_IP 

# getting VM ID
$vms = Get-VM $vm_name 
foreach ($vm in $vms)
{
    Write-Host "VMname: $vm"
    Write-Host "UUID: "
    $vm| %{(Get-View $_.Id).config.uuid}
}

# Disconnect from the vCenter server(s) 
disconnect-viserver $vcserver -Confirm:$False 
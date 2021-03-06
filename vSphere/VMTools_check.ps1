# Script checking if vmtools are running 
# Input: vCenter IP
# Author: Szymon Kędzierski

[CmdletBinding()]
Param (

# vCenter IP
[Parameter (Mandatory=$True)] [string] $vc_IP
)

# Connect to the vCenter server(s) 
$vcserver = Connect-VIServer $vc_IP 

# get the vmware tools version for each VM  

get-vm |%{
    $_ | select Name, @{Name = "Hostname"; Expression = {$_.guest.hostname}}, @{Name="ToolsVersion"; Expression = {$_.Extensiondata.config.tools.toolsVersion}}
}

# Disconnect from the vCenter server(s) 
disconnect-viserver $vcserver -Confirm:$False 
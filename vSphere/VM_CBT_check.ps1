# Script listing CBT configuration on all VMs
# Input: vCenter IP
# Author: Szymon Kędzierski

[CmdletBinding()]
Param (

# vCenter IP
[Parameter (Mandatory=$True)] [string] $vc_IP
)

# Connect to the vCenter server(s) 
$vcserver = Connect-VIServer $vc_IP 

# Get CBT status 
Get-VM | %{ Get-View $_ | Select Name,@{n="CBT_Enabled";e={$_.config.ChangeTrackingEnabled}}}

# Disconnect from the vCenter server(s) 
disconnect-viserver $vcserver -Confirm:$False 
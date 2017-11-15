# Getting all VMs restarted within $days by HA
# Input: vCenter IP, days how long in past logs should be checked
# Author: Szymon Kędzierski

[CmdletBinding()]
Param (

# vCenter IP
[Parameter (Mandatory=$True)] [string] $vc_IP,
[Parameter (Mandatory=$True)] [string] $days

)

# Connect to the vCenter server(s) 
$vcserver = Connect-VIServer $vc_IP 

$Date=Get-Date
Get-VIEvent -maxsamples 100000 -Start ($Date).AddDays(-$days) -type warning | Where {$_.FullFormattedMessage -match "restarted"} |select CreatedTime,FullFormattedMessage |sort CreatedTime -Descending

# Disconnect from the vCenter server(s) 
disconnect-viserver $vcserver -Confirm:$False 

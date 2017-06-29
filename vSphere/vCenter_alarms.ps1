# vCenter Server alarms
# Input: vCenter IP
# Author: Szymon Kędzierski

[CmdletBinding()]
Param (

# vCenter IP
[Parameter (Mandatory=$True)] [string] $vc_IP
)

# Connect to the vCenter server(s) 
$vcserver = Connect-VIServer $vc_IP 

$rootFolder = Get-Folder "Datacenters"
 
foreach ($ta in $rootFolder.ExtensionData.TriggeredAlarmState) 
{
		$alarm = "" | Select-Object EntityType, Alarm, Entity, Status, Time, Acknowledged, AckBy, AckTime
		$alarm.Alarm = (Get-View $ta.Alarm).Info.Name
		$entity = Get-View $ta.Entity
		$alarm.Entity = (Get-View  $ta.Entity).Name
		$alarm.EntityType = (Get-View $ta.Entity).GetType().Name	
		$alarm.Status = $ta.OverallStatus
		$alarm.Time = $ta.Time
		$alarm.Acknowledged = $ta.Acknowledged
		$alarm.AckBy = $ta.AcknowledgedByUser
		$alarm.AckTime = $ta.AcknowledgedTime		
		$alarm
}

# Disconnect from the vCenter server(s) 
disconnect-viserver $vcserver -Confirm:$False 
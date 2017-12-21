
# List all VM that have diffrent configured memory vs memory limit 
# Author: Szymon Kędzierski

$vms= Get-vm
$report = @()

foreach ($vm in $vms)
{
$row = "" | Select Name, "Configured memory", "Limit"
if ($vm.MemoryMB -ne $vm.ExtensionData.ResourceConfig.MemoryAllocation.Limit  -and $vm.ExtensionData.ResourceConfig.MemoryAllocation.Limit -ne "-1")
	{
	$row.Name = $vm.name
 	$row."Configured memory" = $vm.MemoryMB
	$row."Limit"= $vm.ExtensionData.ResourceConfig.MemoryAllocation.Limit
	$report += $row
	}
}
$report | Export-Csv  
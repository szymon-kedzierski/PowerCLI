# Provisioning script  

Script can be used to bulk provision vApps into vCD

## Execution

ruby main.rb configuration.xlsx vCD_username vCD_password

## XLSX file

XLSX must contain two following sheets:

Connection:

|host   |XX.XX.XX.XX |
|-------|------------|
|port   | 	  XXX     |
|apipath| /api       |

VM

|org_name	|vdc_name  	|vapp_name	|catalog_name  	|template_name 	|network_name 	 |computer_name 	|vm_name 	|cpu	|mem MB	|disk_size MB|
|---------|-----------|----------|---------------|---------------|---------------|---------------|---------|----|-------|------------|
|TestOrg  |testvdc    |vapp1     |catalog_test   |CentOS 7.0     |private_network|CentOS         |CentOS   |1   |1024   |20000       |

You can see example.xlsx file.

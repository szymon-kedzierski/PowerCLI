require 'fog/vcloud_director'
require 'Excon'
require 'roo'

require './ProvisioningParameters.rb'
require './PostProvisioningParameters.rb'
require './VCDConnection.rb'
require './VCDApi.rb'
require './VM_vCD.rb'

Excon.defaults[:ssl_verify_peer] = false

xlsx = Roo::Spreadsheet.open(ARGV[0])
xlsx = Roo::Excelx.new(ARGV[0])

vCD1 =VCDConnection.new
connection_vCD1 = vCD1.connect_vCD(xlsx, ARGV[1], ARGV[2])

row=2
while  (xlsx.sheet('VM').cell(row,1) != nil) do

    params1 = ProvisioningParameters.new(xlsx, row)
    post_params1 = PostProvisioningParameters.new(xlsx, row)
    vm1 = VM_vCD.new(connection_vCD1, params1, post_params1)
    
   

    vm1.provision_vm
    vm1.postprovision_vm
    vm1.start_vm_force_cust
    vm1.get_vm
    vm1.print_vm

    # if vm exist you can get object by:
    #vm1.get_vm
    #vm1.print_vm

   
    row+=1

end
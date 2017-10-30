# Input parameters for provisioning
require 'roo'

class ProvisioningParameters
    
    attr_reader :org_name, :vdc_name, :vapp_name, :catalog_name, :template_name, :network_name
      
        def initialize(xlsx, row)

            @org_name           = xlsx.sheet('VM').cell(row,1)
            @vdc_name           = xlsx.sheet('VM').cell(row,2)
            @vapp_name          = xlsx.sheet('VM').cell(row,3)
            @catalog_name       = xlsx.sheet('VM').cell(row,4)
            @template_name      = xlsx.sheet('VM').cell(row,5)
            @network_name       = xlsx.sheet('VM').cell(row,6)
        end
end
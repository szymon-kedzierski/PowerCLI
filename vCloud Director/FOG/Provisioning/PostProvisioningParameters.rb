# Input parameters for postprovisioning
class PostProvisioningParameters
    attr_reader  :computer_name, :vm_name, :cpu, :mem, :disk_size, :metadata

    def initialize(xlsx, row)

        @computer_name = xlsx.sheet('VM').cell(row,7)
        @vm_name = xlsx.sheet('VM').cell(row,8)
        @cpu =xlsx.sheet('VM').cell(row,9)
        @mem = xlsx.sheet('VM').cell(row,10)
        @disk_size = xlsx.sheet('VM').cell(row,11)
    end
end

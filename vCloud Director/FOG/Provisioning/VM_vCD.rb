class VM_vCD

    attr_reader :vm, :vapp, :connection

    def initialize(conn, prov_params, post_prov_params)
        @connection = conn
        @prov_params = prov_params
        @post_prov_param = post_prov_params
    end

    def start_vm_force_cust
        puts "Starting VM #{@vm.name} with recustomization."

        if (@vm.status == "on")
            puts " VM #{@vm.name} is already started. Unable to customize."
        else
            @connection.post_deploy_vapp(@vm.id, forceCustomization:true)
            @vapp.power_on
            @vm.wait_for { ready? }
            if (@vm.status == "on")
                puts "VM #{@vm.name} started."
            else
                puts "Failed to start VM."
            end
        end
    end

    def get_vm

        @org = @connection.organizations.get_by_name(@prov_params.org_name)
        raise "Organization not found!" if @org == nil

        @vdc = @org.vdcs.get_by_name(@prov_params.vdc_name)
        raise "VDC not found in organization #{@org_name}!" if @vdc == nil

        @vapp= @vdc.vapps.get_by_name(@prov_params.vapp_name)
        raise "No vAPP #{@vapp}!" if @vapp == nil
        
        @vm = @vapp.vms.first
        raise "No VM #{@vm}!" if @vm == nil

        #puts "Got VM #{@vm.name}"
        @vm
    end

    def print_vm
        puts "ORG: #{@org.name}"
        puts "VDC: #{@vdc.name}"
        puts "Vapp: #{@vapp.name}"
        puts "VMname: #{@vm.name}"
        puts "Network: #{@vm.network.network}"
    end

    def provision_vm

        puts "Provisioning vApp..."

        org = @connection.organizations.get_by_name(@prov_params.org_name)
        raise "Organization not found!" if org == nil

        vdc = org.vdcs.get_by_name(@prov_params.vdc_name)
        raise "VDC not found in organization #{@org_name}!" if vdc == nil

        catalog = org.catalogs.get_by_name(@prov_params.catalog_name)
        raise "Catalog not found" if catalog == nil

        template = catalog.catalog_items.get_by_name(@prov_params.template_name)
        raise "Template not found" if template == nil

        network = org.networks.get_by_name(@prov_params.network_name)
        raise "Network not found" if network == nil

        #provisioning
        if vdc.vapps.get_by_name(@prov_params.vapp_name) == nil
            template.instantiate(@prov_params.vapp_name,{
            vdc_id: vdc.id,
            network_id: network.id}
            )
            @vapp = vdc.vapps.get_by_name(@prov_params.vapp_name)
            @vm = @vapp.vms.first #only one vm in vapp possible for now
           raise "Not able to create vApp!" if @vm == nil
           @vm
        else
            raise "vApp already exists."
        end
        puts "VM #{@vm.name} provisioned."
        @vm
    end

    def postprovision_vm

        #assign network to VM
       
        network = @vm.network
        network.reload
        puts "Assigning network #{network.network} to VM #{@vm.name}..."
        network.is_connected = true
        network.network_connection_index = 0
        network.primary_network_connection_index = 0
        network.network = @prov_params.network_name
        network.ip_address_allocation_mode = 'POOL'
        network.needs_customization = true
        network.mac_address = ''
        network.save
        network.reload
        raise "Network not assigned." if network.network == nil
        puts "Network #{network.network} assigned to VM #{@vm.name} "

        # VM name change
        ret = @connection.put_vm(@vm.id,@post_prov_param.vm_name,{})
        task_id= ret.data[:body][:id].split(':').last
        puts "Changing VM name..."
        Fog::wait_for(360,5){
            @task = @connection.tasks.get(task_id)
            @task.status == 'success'
        }
        if @task.status == 'failed'
            raise "Changing VM name failed."
        end
        puts "VM name changed."

        #CPU
        puts "Setting CPU count..."
        @vm.cpu = @post_prov_param.cpu
        puts "CPU set to #{@vm.cpu}."

        #Memory
        puts "Setting memory size..."
        @vm.memory = @post_prov_param.mem
        puts "Memory set to #{@vm.memory} MB."

        # For now just one disk
        puts "Changing disk size."
        disk = @vm.disks.get_by_name("Hard disk 1")
        if disk.capacity < @post_prov_param.disk_size
            disk.capacity = @post_prov_param.disk_size
            puts "Disk capacity set to #{disk.capacity} MB ."
        else
            puts "Setting disk size unsuccessful. Minimal capacity is #{disk.capacity}"
        end

        # set customization attributes - computer name
        puts "Setting computer name..."
        customization = @vm.customization
        customization.computer_name = @post_prov_param.computer_name
        customization.enabled = true
        customization.save
        puts "Computer name set."
    end
    
    def get_tag(name)
        get_vm
        if  @vm.tags.get_by_name(name) != NIL
            @vm.tags.get_by_name(name).value
        else
            puts "No metadata #{name} "
        end
    end
end
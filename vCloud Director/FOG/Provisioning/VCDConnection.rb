# Connection parameters
require 'roo'

class VCDConnection 

    attr_reader :connection

    def connect_vCD (xlsx, user, pass)
        puts "Connecting to vCD."
        @connection = Fog::Compute::VcloudDirector.new(
            :vcloud_director_username      => user,
            :vcloud_director_password      => pass,
            :vcloud_director_host          => xlsx.sheet('Connection').cell(1,2),
            :port                          => xlsx.sheet('Connection').cell(2,2),
            :path                          => xlsx.sheet('Connection').cell(3,2),
            :vcloud_director_show_progress => false,
            )
            if @connection == nil 
                raise "Connection to vCD was not possible."
            end
            puts "Connected to vCD."
            @connection
    end
end

class VCDApi

    def initialize(conn)
        @connection = conn
    
    @headers= {
        :content_type => :xml,
        :accept => "application/*+xml;version=9.0",
    }

    @params = {
        :headers => @headers,
        :verify_ssl => false,
    }
    end

    def rest_call()
        response= RestClient::Request.new(@params).execute
        if not [200, 201, 202].include? response.code
            raise "Rest call failed: #{response}"
        end
        response
    end

    def rest_login
        @params[:method] = :post
        @params[:url] = "https://#{@connection.host}/api/sessions"
        
        response = rest_call
        @cookie.response[:x_vcloud_authorization]
        @headers[:x_vcloud_authorization] = @cookie
    end

    def api_call (action, ref= nil, body = nil, return_xml=false )
        @params[:method] = action
        @params[:url] = "https://#{@connection.host}/#{ref}"
        @params[:payload] = body if body
        response = rest_call
        return respone.body if return_xml
        XmlSimple.xml_in(response)
    end
end
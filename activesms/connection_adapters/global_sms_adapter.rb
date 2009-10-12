require 'activesms/connection_adapters/abstract_adapter'

module ActiveSms
  class Base
    def self.global_sms_connection(config) #:nodoc:
      return ConnectionAdapters::GlobalSmsAdapter.new(logger, config)
    end
  end
  
  module ConnectionAdapters
    # All the concrete gateway adapters follow the interface laid down in this
    # class.  You can use this interface directly by borrowing the gateway
    # connection from the Base with Base.connection.
    class GlobalSmsAdapter < AbstractAdapter
      SERVICE_HOST = "www.smsglobal.com.au"
      SERVICE_PATH = "/http-api.php"
      
      def initialize(logger = nil, config = {}) #:nodoc:
        super(logger)
        @config = config.dup
        
        scheme = config[:use_ssl] ? "https" : "http"
        @service_url = "#{scheme}://#{SERVICE_HOST}#{SERVICE_PATH}"
      end
      
      # Return the human readable name of the gateway adapter.
      def adapter_name
        return 'GlobalSMS'
      end
      
      def deliver(sms)
        params = {
          :action   => 'sendsms',
          :user     => @config[:user],
          :password => @config[:password],
          :to       => sms.recipients,
          :from     => sms.from,
          :text     => sms.body
        }
        send_http_request(@service_url, params)
      end
    end
  end
end

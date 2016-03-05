module WistfulIndie
  module Twitter
    class Client
      def self.client
        @client ||= new.client
      end

      def client
        @client ||= ::Twitter::REST::Client.new do |config|
          config.consumer_key        = 'QUEPvngTJOBuXBR77obcPIDaj'
          config.consumer_secret     = '4WZaVFoHHqTB0jtsoqUx3Rt47yD5o0sPUvIL0b4YNGMurJSG3s'
          config.access_token        = '704175249202540544-t9BncEjDuxz9OUDwZ2e7MXWFKrlaYtx'
          config.access_token_secret = '1jf7DkNdeer1ZJGokgBtvVrhXVDWnriJeXi1YUQXs7whS'
        end
      end

      protected

      def initialize; end
    end
  end
end

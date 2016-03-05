module WistfulIndie
  module Twitter
    class Client
      def self.client
        @client ||= new.client
      end

      def client
        @client ||= ::Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV['CONSUMER_KEY']
          config.consumer_secret     = ENV['CONSUMER_SECRET']
          config.access_token        = ENV['ACCESS_TOKEN']
          config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
        end
      end

      protected

      def initialize; end
    end
  end
end

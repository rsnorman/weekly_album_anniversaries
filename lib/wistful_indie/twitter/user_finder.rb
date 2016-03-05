require_relative 'client'

module WistfulIndie
  module Twitter
    class UserFinder
      def initialize(client = WistfulIndie::Twitter::Client.client)
        @client = client
      end

      def for_artist(artist)
        best_matching_user(artist).try(:screen_name)
      end

      def all_verified_for_artist(artist)
        most_followers(only_verified(find_users(artist))).map(&:screen_name)
      end

      private

      def best_matching_user(artist)
        most_followers(only_verified(find_users(artist))).first
      end

      def find_users(query)
        client.user_search(query)
      end

      def only_verified(users)
        users.select(&:verified?)
      end

      def most_followers(users)
        users.sort_by(&:followers_count).reverse
      end

      attr_reader :client
    end
  end
end

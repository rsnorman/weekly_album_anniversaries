# frozen_string_literal: true

module FunFacts
  # Tweets fun facts about albums
  class FunFactTweeter
    def self.tweet_about(album)
      new(album: album).tweet
    end

    def initialize(album:,
                   twitter_client: WistfulIndie::Twitter::Client.client)
      raise ArgumentError, 'Must pass an album' if album.nil?

      @client = twitter_client
      @album = album
    end

    def tweet
      return unless fun_fact?

      Rails.logger.info "Tweeting fun fact for #{album.artist.name} - #{album.name}"
      @client.update(tweet_text)
    end

    private

    attr_reader :album

    def fun_fact?
      album.fun_fact.present?
    end

    def tweet_text
      album.generated_fun_fact_description
    end
  end
end

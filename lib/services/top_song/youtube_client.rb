# frozen_string_literal: true

require 'open-uri'
require 'cgi'

module TopSong
  class YoutubeClient
    DEVELOPER_KEY = ENV['GOOGLE_DEV_KEY']

    def self.find(query)
      new(query).find
    end

    def initialize(query, api_key: DEVELOPER_KEY)
      @query = query
      @api_key = api_key
    end

    def find
      search_response['items'].map do |search_result|
        "https://www.youtube.com/watch?v=#{search_result['id']['videoId']}"
      end.first
    end

    private

    def search_response
      @search_response ||=
        JSON.parse(OpenURI.open_uri(youtube_search_url).read)
    end

    def youtube_search_url
      encoded_query = CGI.escape(@query)
      "https://content.googleapis.com/youtube/v3/search?part=id,snippet&q=#{encoded_query}&key=#{@api_key}&type=video&topic=/m/04rlf&maxResults=1"
    end
  end
end

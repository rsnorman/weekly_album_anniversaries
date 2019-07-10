# frozen_string_literal: true

module Admin
  class ScheduledTweetsController < Admin::AdminController
    before_action :set_scheduled_tweets, only: :index
    before_action :set_scheduled_tweet, only: :update

    def index
      respond_to do |format|
        format.html {}
        format.json { render json: api_json_for(@scheduled_tweets) }
      end
    end

    def update
      respond_to do |format|
        format.json do
          @scheduled_tweet.update(scheduled_tweet_attributes)
          render json: api_json_for(@scheduled_tweet)
        end
      end
    end

    private

    def api_json_for(_scheduled_tweets)
      decorator.to_api_json
    end

    def set_scheduled_tweets
      if params[:all] == 'true'
        @scheduled_tweets = ScheduledTweet.all
      else
        @scheduled_tweets = ScheduledTweet.during_dates(Week.current.range)
      end
    end

    def set_scheduled_tweet
      @scheduled_tweet = ScheduledTweet.find(params[:id])
    end

    def scheduled_tweet_attributes
      params.require(:scheduled_tweet).permit(:scheduled_at)
    end

    def decorator
      ScheduledTweetJsonDecorator.new(@scheduled_tweets || @scheduled_tweet,
                                      singular: @scheduled_tweets.nil?)
    end
  end
end

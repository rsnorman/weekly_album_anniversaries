module Admin
  class ScheduledTweetsController < Admin::AdminController
    before_action :set_scheduled_tweets, only: :index
    before_action :set_scheduled_tweet, only: :update

    def index
      respond_to do |format|
        format.html { }
        format.json { render json: api_json_for(@scheduled_tweets) }
      end
    end

    def update
      @scheduled_tweet.update(scheduled_tweet_attributes)
      head :ok
    end

    private

    def api_json_for(scheduled_tweets)
      decorator.to_api_json
    end

    def set_scheduled_tweets
      @scheduled_tweets = ScheduledTweet.during_dates(Week.current.range)
    end

    def set_scheduled_tweet
      @scheduled_tweet = ScheduledTweet.find(params[:id])
    end

    def scheduled_tweet_attributes
      params.require(:scheduled_tweet).permit(:twitter_screen_name)
    end

    def decorator
      ScheduledTweetJsonDecorator.new(@scheduled_tweets)
    end
  end
end

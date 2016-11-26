# Unfollows accounts that haven't followed back
class TwitterAccountUnfollower
  def initialize(twitter_client: WistfulIndie::Twitter::Client.client,
                 accounts: TwitterFollow.ungrateful)
    @twitter_client = twitter_client
    @accounts = accounts
  end

  def unfollow
    @accounts.each do |account|
      @twitter_client.unfollow(account.twitter_id.to_i)
      account.destroy
    end
  rescue Twitter::Error::TooManyRequests
    Rails.logger.error 'Too many unfollows'
  end
end

# - Not following WI
# - Not an artist account
#   - Artist not tied to TwitterFollow
#   - Account screen name not matching artist screen name
# - Followed more than a week ago

# Accounts that were followed more than a week ago and never followed back
class UngratefulTwitterFollows
  MIN_TIME_FOR_FOLLOW_BACK = 7.days.freeze

  def self.all
    new.all
  end

  def all
    TwitterFollow
      .where('created_at <= ?', Time.current - MIN_TIME_FOR_FOLLOW_BACK)
      .where(is_friend: false, artist: nil)
      .where.not(screen_name: artist_screen_names)
  end

  private

  def artist_screen_names
    Artist.pluck(:twitter_screen_name) -
      TwitterFollow.where.not(artist: nil).pluck(:screen_name)
  end
end

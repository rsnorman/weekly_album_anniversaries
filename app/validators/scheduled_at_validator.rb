# frozen_string_literal: true

# Validator that makes sure a release is in a logical range
class ScheduledAtValidator < ActiveModel::Validator
  def validate(scheduled_tweet)
    return unless already_scheduled?(scheduled_tweet)

    scheduled_tweet.errors[:scheduled_at] << "already scheduled a #{scheduled_tweet.type} tweet for album"
  end

  private

  def already_scheduled?(scheduled_tweet)
    week = Week.new(scheduled_tweet.scheduled_at)
    ScheduledTweet
      .where(scheduled_at: week.range,
             album: scheduled_tweet.album,
             type: scheduled_tweet.type)
      .where.not(id: scheduled_tweet.id)
      .any?
  end
end

# frozen_string_literal: true

# Returns an album that was recently highlighted
class RecentHighlightedAlbum
  MAX_HIGHLIGHTED_TIME = 3.hour.freeze

  def self.find
    new.find
  end

  def initialize(max_highlighted_time: MAX_HIGHLIGHTED_TIME)
    @max_highlighted_time = max_highlighted_time
  end

  def find
    return unless highlighted_album

    highlighted_album.album
  end

  private

  def highlighted_album
    @highlighted_album ||= HighlightedAlbum
                           .where('created_at > ?', @max_highlighted_time.ago)
                           .last
  end
end

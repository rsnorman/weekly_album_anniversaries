# Returns an album that was recently highlighted
class RecentHighlightedAlbum
  MAX_HIGHLIGHTED_TIME = 1.hour.freeze

  def self.find
    new.find
  end

  def find
    return unless highlighted_album
    highlighted_album.album
  end

  private

  def highlighted_album
    @highlighted_album ||= HighlightedAlbum
      .where('created_at > ?', MAX_HIGHLIGHTED_TIME.ago)
      .last
  end
end

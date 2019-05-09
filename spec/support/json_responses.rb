# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
def anniversary_json(album)
  {
    'name' => album.name,
    'artist' => album.artist.name,
    'uuid' => album.uuid,
    'thumbnail_url' => album.thumbnail,
    'release_date' => album.release_date.in_time_zone.to_i,
    'release_date_string' => album.release_date.to_s,
    'age' => album.anniversary.count,
    'day_of_week' => album.anniversary.current.strftime('%A'),
    'anniversary' => album.anniversary.current.in_time_zone.to_i,
    'anniversary_string' => album.anniversary.current.to_s,
    'rating' => album.rating.to_s,
    'review_link' => album.link,
    'link' => "/albums/#{album.slug}"
  }
end
# rubocop:enable Metrics/AbcSize

require 'open-uri'
require 'nokogiri'

# Returns screen names of recent twitter interactions
class RecentTwitterInteractors
  FAVSTAR_RECENT_URI = 'https://favstar.fm/users/wistfulindie/recent'.freeze

  def self.screen_names
    new.screen_names
  end

  def screen_names
    anchor_elements
      .map do |el|
        el.attr('title').tr('@', '')
      end
      .select do |sn|
        !sn.empty?
      end
      .uniq
  end

  private

  def anchor_elements
    favstar_page.css('a.fs-avatar')
  end

  def favstar_page
    @favstar_page ||= Nokogiri::HTML(OpenURI.open_uri(FAVSTAR_RECENT_URI))
  end
end

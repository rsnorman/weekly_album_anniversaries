def random_weekly_release_date
  Date.current.beginning_of_week(:sunday) + rand(0..6).days - rand(2..20).years
end

# albums = [
#   ["Funeral", "Arcade Fire"], ["Pretty Hate Machine", "Nine Inch Nail"],
#   ["Lifted", "Bright Eyes"], ["Go Tell Fire To The Mountain", "WU LYF"],
#   ["Shrines", "Purity Ring"], ["Bleach", "Nirvana"], ["Greetings From Michigan", "Sufjan Stevens"],
#   ["For Emma, Forever Ago", "Bon Iver",], ["Battle of Los Angeles", "Rage Against The Machine"],
#   ["Post-Nothing", "Japandroids"], ["Here And Nowhere Else", "Cloud Nothings"],
#   ["The Monitor", "Titus Andronicus"], ["Yankee Foxtrot Hotel", "Wilco"]
# ]

# Genre.destroy_all
# Album.destroy_all

# genre = Genre.create!(name: "Indie Rock")

# albums.each do |album, artist|

#   unless Album.where(:name => album).count > 0
#     Album.create!(genre:         genre,
#                    name:         album,
#                    artist:       artist,
#                    thumbnail:    "#{album.downcase.gsub(' ', '_')}.jpg",
#                    release_date: random_weekly_release_date)
#     puts "Create #{album}"
#   else
#     puts "#{album} already exists"
#   end

# end


require 'open-uri'

def get_page(url)
  Nokogiri::HTML(open(url))
end

def get_albums(page)
  page.css('.bnm-list li')
end

def get_next_page(page)
  next_link = page.css('.next-container .next')
  if next_link.size.zero?
    nil
  else
    get_page("http://pitchfork.com#{next_link.attr('href')}")
  end
end

page = get_page("http://pitchfork.com/reviews/best/albums/")

while page
  inserted_albums = []
  error_albums = []
  get_albums(page).each do |album_node|
    album = Album.new
    begin
      album.thumbnail = album_node.css('.artwork div').attr('data-content').value.split('"')[1]
      album.link = "http://pitchfork.com#{album_node.css('.info a:first').attr('href')}"
      album.artist = album_node.css('.info h1').text
      album.name = album_node.css('.info h2').text
      album.release_date = Date.strptime(album_node.css('.info h4').text.split(';').last.strip, "%B %d, %Y")
      album.rating = album_node.css('.score').text.strip
      album.save!
      inserted_albums << album
    rescue
      error_albums << album if album.name
    end
  end

  inserted_albums.each do |album|
    puts "Inserted #{album.name} by #{album.artist}"
  end

  error_albums.each do |album|
    puts "Failed inserting #{album.name} by #{album.artist}"
  end

  page = get_next_page(page)

  sleep rand(1..20)
end


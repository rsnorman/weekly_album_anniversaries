def random_weekly_release_date
  Date.current.beginning_of_week(:sunday) + rand(0..6).days - rand(2..20).years
end

albums = [
  ["Funeral", "Arcade Fire"], ["Pretty Hate Machine", "Nine Inch Nail"],
  ["Lifted", "Bright Eyes"], ["Go Tell Fire To The Mountain", "WU LYF"],
  ["Shrines", "Purity Ring"], ["Bleach", "Nirvana"], ["Greetings From Michigan", "Sufjan Stevens"],
  ["For Emma, Forever Ago", "Bon Iver",], ["Battle of Los Angeles", "Rage Against The Machine"],
  ["Post-Nothing", "Japandroids"], ["Here And Nowhere Else", "Cloud Nothings"],
  ["The Monitor", "Titus Andronicus"], ["Yankee Foxtrot Hotel", "Wilco"]
]

Genre.destroy_all
Album.destroy_all

genre = Genre.create!(name: "Indie Rock")

albums.each do |album, artist|

  unless Album.where(:name => album).count > 0
    Album.create!(genre:         genre,
                   name:         album,
                   artist:       artist,
                   thumbnail:    "#{album.downcase.gsub(' ', '_')}.jpg",
                   release_date: random_weekly_release_date)
    puts "Create #{album}"
  else
    puts "#{album} already exists"
  end

end

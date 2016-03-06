content = File.read('./db/seed_data/artists.json').strip
artists = JSON.parse(content)

artists.each do |a|
  ar = Artist.find_by(name: a['name'])
  ar && ar.update(twitter_screen_name: a['twitter_screen_name'])
end

artists.each do |a|
  ar = Artist.find_by(name: a['name'])
  ar && a['potential_twitter_screen_names'].each do |sn|
    PotentialTwitterScreenName.create(
      artist: ar,
      screen_name: sn['screen_name'],
      strength: sn['strength']
    )
  end
end

namespace :weekly_albums do
  desc "Finds obvious twitter screen names and assigns to users"
  task :set_twitter_screen_name => :environment do
    require './lib/wistful_indie/twitter/user_finder'
    require './lib/word_match_strength_calculator'

    MINIMUM_MATCH_STRENGTH = 40
    MINIMUM_MULTIPLE_MATCH_STRENGTH = 90

    puts "Setting Twitter screen names..."
    finder = WistfulIndie::Twitter::UserFinder.new

    Artist.where(twitter_screen_name: nil).where.not(id: PotentialTwitterScreenName.pluck(:artist_id).uniq).limit(90).each do |artist|
      begin
        strength_calc = WordMatchStrengthCalculator.new(artist.name)

        puts "Fetching twitter accounts for #{artist.name}"
        screen_names = finder.all_verified_for_artist(artist.name)
        if screen_names.empty?
          artist.update(twitter_screen_name: 'UNKNOWN')
          next
        end

        if screen_names.size > 1
          screen_names_with_strength = screen_names.map do |sn|
            {
              screen_name: sn,
              match_strength: strength_calc.calculate_match_strength(sn)
            }
          end
          screen_names_with_strength = screen_names_with_strength.sort do |a, b|
            b[:match_strength] <=> a[:match_strength]
          end

          if screen_names_with_strength.first[:match_strength] > MINIMUM_MULTIPLE_MATCH_STRENGTH
            puts "Found twitter name: @#{screen_names_with_strength.first[:screen_name]}"
            artist.update(twitter_screen_name: screen_names_with_strength.first[:screen_name])
          else
            screen_names_with_strength.each do |screen_name_with_strength|
              PotentialTwitterScreenName.create(
                artist: artist,
                screen_name: screen_name_with_strength[:screen_name],
                strength: screen_name_with_strength[:match_strength]
              )
            end
          end

        elsif strength_calc.calculate_match_strength(screen_names.first) < MINIMUM_MATCH_STRENGTH
          PotentialTwitterScreenName.create(
            artist: artist,
            screen_name: screen_names.first,
            strength: strength_calc.calculate_match_strength(screen_names.first)
          )
        else
          puts "Found twitter name: @#{screen_names.first}"
          artist.update(twitter_screen_name: screen_names.first)
        end
      rescue StandardError => e
        puts "Failed to get twitter name for #{artist.name} because: #{e.inspect}"
        artist.update(twitter_screen_name: 'UNKNOWN')
      end
    end
    puts "Finished setting all artist screen names"
  end
end

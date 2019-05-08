# frozen_string_literal: true

require './lib/wistful_indie/twitter/user_finder'
require './lib/word_match_strength_calculator'

module WistfulIndie
  module Twitter
    class ScreenNameAssigner
      MINIMUM_MATCH_STRENGTH = 40
      MINIMUM_MULTIPLE_MATCH_STRENGTH = 90

      def initialize(artist, finder = WistfulIndie::Twitter::UserFinder.new)
        @artist = artist
        @finder = finder
      end

      def assign
        return false if potential_screen_names.empty?

        if best_screen_name_match.strength > minimum_match_strength
          artist.update(twitter_screen_name: best_screen_name_match.screen_name)
        else
          potential_screen_names.each do |screen_name|
            PotentialTwitterScreenName.create(
              artist: artist,
              screen_name: screen_name,
              strength: strength_calculator.calculate_match_strength(screen_name)
            )
          end
          false
        end
      end

      private

      attr_reader :artist, :finder

      def minimum_match_strength
        multiple_screen_names? ? MINIMUM_MULTIPLE_MATCH_STRENGTH : MINIMUM_MATCH_STRENGTH
      end

      def strength_calculator
        @strength_calc ||= WordMatchStrengthCalculator.new(artist.name)
      end

      def potential_screen_names
        return @screen_names if @screen_names

        @screen_names = finder.all_verified_for_artist(artist.name)
      rescue StandardError => e
        puts "Failed to get twitter names for #{artist.name} because: #{e.inspect}"
        @screen_names = []
      end

      def multiple_screen_names?
        potential_screen_names.size > 1
      end

      def screen_names_by_strength
        @screen_names_by_strength ||= potential_screen_names.map do |screen_name|
          PotentialTwitterScreenName.new(
            artist: artist,
            screen_name: screen_name,
            strength: strength_calculator.calculate_match_strength(screen_name)
          )
        end.sort do |a, b|
          b.strength <=> a.strength
        end
      end

      def best_screen_name_match
        @best_screen_name_match ||= screen_names_by_strength.first
      end
    end
  end
end

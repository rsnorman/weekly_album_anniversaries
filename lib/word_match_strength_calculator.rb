# Calculates the strength of two words matching
class WordMatchStrengthCalculator
  def initialize(word)
    @word = word.downcase
  end

  def calculate_match_strength(other_word)
    match_count = 0
    other_word = other_word.downcase
    match_indices = []

    word_characters.each_with_index do |char, index|
      if char == other_word[index]
        match_count += 1
        match_indices << index
      end
    end

    other_word_match_indices = []
    word_characters.each_with_index do |char, index|
      next if match_indices.include?(index)
      if (match_index = get_index(char, other_word, match_indices.concat(other_word_match_indices)))
        match_count += (1 - Math.log10((match_index - index + 0.5).abs.to_f))
        other_word_match_indices << match_index
      end
    end

    return 0 if match_count.zero?
    (match_count / word.size.to_f * 100).round.to_i
  end

  private

  def word_characters
    @chars ||= word.split('')
  end

  def get_index(char, word, skip_indices)
    word.split('').each_with_index do |other_char, index|
      next if skip_indices.include?(index)
      return index if char == other_char
    end
    nil
  end

  attr_reader :word
end

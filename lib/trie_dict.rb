# frozen_string_literal: true

class TrieDict
  attr_reader :dict

  def initialize
    @dict = {}
  end

  def put(str)
    d = nil
    str.downcase.chars.each do |c|
      d && (d = (d[1][c] ||= [nil, {}])) || d = (@dict[c] ||= [nil, {}])
    end
    d[0] = true
  end

  def fetch(prefix, fuzzy = 0)
    storage = []
    str = ''
    error = 0
    recur_fetch(prefix.downcase, fuzzy, @dict, storage, str, error)
    storage
  end

  private

  # rubocop:disable Metrics/ParameterLists
  def recur_fetch(prefix, fuzzy, dict, storage, str, error)
    dict.each do |k, vals|
      e = error
      if prefix[0] != k
        e += 1
        next if e > fuzzy
      end
      s = str + k
      storage << s if vals[0] && (prefix.size - 1) <= (fuzzy - e)
      recur_fetch(prefix[1..-1] || '', fuzzy, vals[1], storage, s, e)
    end
  end
  # rubocop:enable Metrics/ParameterLists
end

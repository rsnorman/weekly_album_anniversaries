class TrieDict
  attr_reader :dict

  def initialize
    @dict = {}
  end

  def put(str)
    d = nil
    str.chars.each do |c|
      d && (d = (d[1][c] ||= [nil, {}])) || d = (@dict[c] ||= [nil, {}])
    end
    d[0] = true
  end

  def fetch(prefix, fuzzy = 0)
    storage = []
    str = ""
    error = 0
    recur_fetch(prefix, fuzzy, @dict, storage, str, error)
    storage
  end

  private

  def recur_fetch(prefix, fuzzy, dict, storage, str, error)
    dict.each do |k, vals|
      e = error
      if prefix[0] != k
        e += 1
        next  if e > fuzzy
      end
      s = str + k
      storage << s  if vals[0] && (prefix.size - 1) <= (fuzzy - e)
      recur_fetch(prefix[1..-1] || "", fuzzy, vals[1], storage, s, e)
    end
  end
end

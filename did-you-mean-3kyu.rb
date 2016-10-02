require('pp')
require('pry-byebug')

class Dictionary
  def initialize(words)
    @words = words
  end

  # solution relies on term not containing '!' or '?' characters
  def find_most_similar(term)

    match_scores = @words.map { |word|

      index = 0
      possibilities = [term.dup]

      while index < word.length
        new_possibilities = []
        possibilities.each { |poss|

          if word[index] == poss[index]
            new_possibilities.push(poss.dup)
          else
            # '!' stands for inserted character'
            # '?' stands for replaced character'
            char_inserted = poss.dup.insert(index, '!')
            char_replaced = poss.dup
            char_replaced[index] = '?'
            new_possibilities.push(char_inserted)
            new_possibilities.push(char_replaced)
          end

        }

        possibilities = new_possibilities
        index += 1

      end

      possibilities.map { |poss|

        poss.scan(/\?/).count + poss.scan(/!/).count
      }.min
    }

    return @words[match_scores.index(match_scores.min)]

  end
end

words=['strawberry', 'cherry', 'peach', 'pineapple', 'melon', 'raspberry', 'apple', 'coconut', 'banana']

test_dict=Dictionary.new(words)

puts test_dict.find_most_similar('erry')

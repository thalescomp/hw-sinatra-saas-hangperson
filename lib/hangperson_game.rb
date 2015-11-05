class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError if letter.nil? or letter.empty? or not letter.match(/[[:alpha:]]/)
    letter.downcase!
    unless @guesses.include? letter or @wrong_guesses.include? letter
      if @word.include? letter
        @guesses << letter
      else
        @wrong_guesses << letter
      end
      return true
    end
    
    false
  end
      
  def word_with_guesses
    @word.gsub(/[^#{@guesses} ]/,'-')
  end
  
  def check_win_or_lose
    return :win if @guesses.length == word.length
    return :lose if @wrong_guesses.length == 7
    :play
  end
end

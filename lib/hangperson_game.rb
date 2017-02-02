class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  attr_accessor :word, :guesses, :wrong_guesses
  LOSE = 7
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  
  def guess(letter)
    # only return true if valid guess
    raise(ArgumentError) if letter.nil? ||letter.empty? || letter =~ /[^a-z]/i
    letter.downcase!
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    if word.include?(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end
  end
  
  def word_with_guesses
    @word.split('').map do |letter|
      if @guesses.include?(letter)
        letter
      else 
        "-"
      end
    end.join
  end
  
  def check_win_or_lose
    if word_with_guesses.match(/[a-z]{#{word.length}}/i)
      :win
    elsif @wrong_guesses.length==7
      :lose
    else
      :play
    end
      
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

require "byebug"
class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
 def self.random_word
  DICTIONARY.sample
 end


  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length){"_"}
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char)
    false
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.split("").each.with_index do |ele, i|
      indices << i if char == ele
    end
    indices
  end

  def fill_indices(char, indices)
    indices.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
   guessed = self.already_attempted?(char)
   indices = self.get_matching_indices(char)
   @remaining_incorrect_guesses -= 1 if indices.length == 0
   self.fill_indices(char, indices)
   if guessed
    puts "that has already been attempted"
    return false
   else
    @attempted_chars << char
    return true
   end
  end

  def ask_user_for_guess
    puts "Enter a char: "
    char = gets.chomp
    self.try_guess(char)
  end

  def win?
    # debugger
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    else
       false
    end
end

def lose?
  if @remaining_incorrect_guesses == 0
    puts "LOSE"
    return true
  else
    false
  end
end

def game_over?
  won = self.win?
  lost = self.lose?
  if won || lost
    puts @secret_word
    return true
  else 
    false
  end
end

end

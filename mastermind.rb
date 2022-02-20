# frozen_string_literal: true

# Methods of the Mastermind Game.
module PlayerMode
  def create
    Array.new(4) { rand(1..6) }
  end

  def say_guess
    puts 'Try to guess the 4 secret numbers.'
  end

  def say_end
    puts 'Sorry, you ran out of tries.'
  end

  def say_congrats
    puts "\nCongratulations! You break the code."
  end

  def reveal(secrets)
    puts "Secret numbers were #{secrets}"
  end

  def guess_keeper
    i = 0
    guesses = []
    ordinal = %w[first second third fourth]
    while i < 4
      puts "Please guess the #{ordinal[i]} number:"
      guesses << gets.to_i
      i += 1
    end
    puts "\nYour guesses = #{guesses}"
    guesses
  end

  def announce(correct, partial)
    puts "▶ #{correct} correct answer in the 'right' place."
    puts "▷ #{partial} correct answer in the 'wrong' place.\n "
  end

  def compare(secrets, guesses)
    correct = 0
    partial = 0
    guesses.each_index do |i|
      if guesses[i] == secrets[i]
        correct += 1
      elsif guesses.include?(secrets[i])
        partial += 1
      end
    end
    announce(correct, partial)
    correct == 4
  end
end

module IntelligenceMode
  def establish_your_list
    i = 0
    your_nums = []
    ordinal = %w[first second third fourth]
    while i < 4
      puts "Enter your #{ordinal[i]} number:"
      num = gets.to_i
      your_nums << num
      i += 1
    end
    puts "\nYour number sequence = #{your_nums}"
    your_nums
  end

  def computer_random_guess
    comp_guess = Array.new(4) { rand(1..6) }
    puts "\nComputer's guess = #{comp_guess}"
    comp_guess
  end

  def compare(secret)
    p guess = computer_random_guess
    p secret
    correct = 0
    partial = 0

    if guess == secret
      correct = 4
      true
    else
      guess.each_index do |i|
        if guess[i] == secret[i]
          correct += 1
        elsif guess.include?(secret[i])
          partial += 1
        end
      end
    end
    announce(correct, partial)
  end

  def announce(correct, partial)
    puts "▶ #{correct} correct answer in the 'right' place."
    puts "▷ #{partial} correct answer in the 'wrong' place.\n "
  end

  def say_create
    puts 'Create a sequence that contains 4 numbers between 1-6.'
  end

  def say_good_news
    puts "Congratulations! Coumputer couldn't succeed.\n "
  end

  def say_bad_news
    puts "\nComputer broke the code!"
  end

end

# Computer creates the secret code, player guesses.
class YouGuess
  include PlayerMode
  attr_accessor :turn

  def initialize
    say_guess
    @turn = 0
  end

  def play
    secrets = create
    while turn < 12
      guesses = guess_keeper
      if !compare(secrets, guesses)
        @turn += 1
      else
        break
      end
    end

    # When breaks from the while loop, checks why and responds accordingly.
    if turn < 12
      say_congrats
    else
      say_wow
      reveal(secrets)
    end
  end
end

# Player creates the secret code, computer tries to find out.
class YouCreate
  include IntelligenceMode
  attr_accessor :turn, :secret

  def initialize
    say_create
    @turn = 0
    @secret = establish_your_list
  end

  def play
    while turn < 12 && !compare(secret)
      @turn += 1
      sleep 1
    end

    # When breaks from the while loop, checks why and responds accordingly.
    if turn < 12
      say_bad_news
    else
      say_good_news
    end
  end
end

# YouGuess.new.play
YouCreate.new.play

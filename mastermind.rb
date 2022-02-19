# frozen_string_literal: true

# Methods of the Mastermind Game.
module Game
  def create
    Array.new(4) { rand(1..6) }
  end

  def welcome
    puts 'Welcome to the Mastermind Game!'
  end

  def say_guess
    puts 'Try to guess the 4 secret numbers.'
  end

  def say_create
    puts 'Create a sequence that contains 4 numbers.'
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
      puts "\nPlease guess the #{ordinal[i]} number:"
      guesses << gets.to_i
      i += 1
    end
    puts "Your guesses = #{guesses}"
    guesses
  end

  def announce(correct, partial)
    puts "▶ #{correct} correct answer in the 'right' place."
    puts "▷ #{partial} correct answer in the 'wrong' place."
  end

  def compare(secrets, guesses)
    correct = 0
    partial = 0
    secrets.each_index do |i|
      if secrets[i] == guesses[i]
        correct += 1
      elsif secrets.include?(guesses[i])
        partial += 1
      end
    end
    announce(correct, partial)
    correct == 4
  end
end

# Computer creates the secret code, player guesses.
class Guess
  include Game
  attr_accessor :turn

  def initialize
    welcome
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
      say_end
      reveal(secrets)
    end
  end
end

# Player creates the secret code, computer tries to find out.
# Will be added.
class Create
  include Game
  def initialize
    welcome
    say_create
  end
end

Guess.new.play
# y = Create.new

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
      puts "Computer secrets = #{secrets}"
      guesses.each_index do |i|
        if guesses[i] == secrets[i]
          correct += 1
        elsif secrets[0...i].include?(guesses[i])
          partial += 1
        end
      end
      announce(correct, partial)
      correct == 4
    end
  end
  
  module CreatorMode
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
  
  
  
    def compare(secret)
      nums = (1..6).to_a
      perm = nums.repeated_permutation(4).to_a
      correct = 0
      partial = 0
  
      while correct < 4
        correct = 0
        partial = 0
        perm.shuffle!
        puts "Comupter guess = #{perm[0]}"
        # Peg method
        perm[0].each_index do |i|
          if perm[0][i] == secret[i]
            correct += 1
          elsif secret[0..i].include?(perm[0][i])
            partial += 1
          else
            perm.delete_if { |array| array.include?(array[0][i]) }
          end
        end
        announce(correct, partial)
      end
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
  class PlayerGuess
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
  class ComputerGuess
    include CreatorMode
    attr_accessor :turn, :secret
  
    def initialize
      say_create
      @turn = 0
      @secret = establish_your_list
    end
  
    def play
      compare(secret)
  
      # When breaks from the while loop, checks why and responds accordingly.
      # if turn < 12
      #   say_bad_news
      # else
      #   say_good_news
      # end
    end
  end
  
  # PlayerGuess.new.play
  ComputerGuess.new.play
  # all the nums = [1 ,2, 3, 4, 5, 6]
  
  #  secret code = [5, 1, 4, 5]
  
  # guess_x = [first, second, third, fourth]
  
  
  # first = 1
  # second = 1
  # third = 1
  # fourth = 1
  
  # guess_y = guess_x
  
  # if correct + parital  = 0 
  #   incremnt all the variables by 1
  # elsif correct == 1
  #   second third fourth inrement by 1
  # elsif partial == 1
  
  
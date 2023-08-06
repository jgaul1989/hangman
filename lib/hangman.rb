# frozen_string_literal: true

require_relative 'ascii_art'
require 'json'

# class for a game of hangman
class Hangman
  attr_accessor :secret_word, :hidden_secret_word, :num_incorrect_guesses, :guessed_letters

  include AsciiArt
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = []
    @hidden_secret_word = []
    @guessed_letters = []
    @num_incorrect_guesses = 0
  end

  def select_word
    @secret_word = pick_random_word
    @hidden_secret_word = hide_secret_word
  end

  def add_letter(letter)
    letter_indices = @secret_word.each_index.select { |index| @secret_word[index] == letter }
    @num_incorrect_guesses += 1 if letter_indices.empty?
    @guessed_letters.push(letter)

    letter_indices.each do |index|
      @hidden_secret_word[index] = letter
    end
  end

  def select_letter
    puts "\nPick a letter: "
    user_guess = gets.chomp.downcase
    while @guessed_letters.include? user_guess
      puts 'Letter already selected!'
      puts "Selected letters #{@guessed_letters}"
      puts 'Pick a letter: '
      user_guess = gets.chomp
    end
    user_guess
  end

  def serialize
    JSON.dump({
                secret_word: @secret_word,
                hidden_secret_word: @hidden_secret_word,
                guessed_letters: @guessed_letters,
                num_incorrect_guesses: @num_incorrect_guesses
              })
  end

  def deserialize(string)
    data = JSON.parse(string)
    self.secret_word = data['secret_word']
    self.hidden_secret_word = data['hidden_secret_word']
    self.guessed_letters = data['guessed_letters']
    self.num_incorrect_guesses = data['num_incorrect_guesses']
  end

  def pick_random_word
    @dictionary.sample.strip.downcase.split('')
  end

  def hide_secret_word
    Array.new(@secret_word.length, '_')
  end

  def print_information(game_over: false)
    print_hang_man(@num_incorrect_guesses)
    puts @hidden_secret_word.join(' ')
    puts "\n#{6 - @num_incorrect_guesses} lives remaining"
    puts "Guessed letters #{@guessed_letters}"
    puts "The secret word was #{@secret_word.join('')}" if game_over
  end
end

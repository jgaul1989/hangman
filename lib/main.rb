# frozen_string_literal: true

require_relative 'hangman'
require 'json'

def read_words
  valid_words = []
  File.foreach('../english_words.txt') do |line|
    valid_words.push(line) if line.strip.length.between?(5, 12)
  end
  valid_words
end

def save_game(hangman)
  puts 'Game saved!'
  Dir.mkdir('../output') unless Dir.exist?('../output')
  File.write('../output/saved_game.json', hangman.serialize)
end

def load_game
  File.read('../output/saved_game.json')
end

def play(hangman)
  while (hangman.hidden_secret_word.include? '_') && (hangman.num_incorrect_guesses < 6)
    hangman.print_information
    puts 'Do you want to save your game? y/n'
    end_game = gets.chomp.downcase
    save_game(hangman) if end_game == 'y'
    return if end_game == 'y'

    letter = hangman.select_letter
    hangman.add_letter(letter)
  end
  hangman.print_information(game_over: true)
end

dictionary = read_words
puts 'Do you want to load a saved game?(y/n)'
new_game = gets.chomp.downcase
hangman = Hangman.new(dictionary)
if new_game == 'y'
  hangman.deserialize(load_game)
else
  hangman.select_word
end
play(hangman)

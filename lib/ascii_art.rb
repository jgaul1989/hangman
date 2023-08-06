# frozen_string_literal: true

# module for printing hangman ascii art
module AsciiArt
  def print_hang_man(stage)
    case stage
    when 0 then print_stage_zero
    when 1 then print_stage_one
    when 2 then print_stage_two
    when 3 then print_stage_three
    when 4 then print_stage_four
    when 5 then print_stage_five
    when 6 then print_stage_six
    end
  end

  def print_stage_zero
    puts <<-HEREDOC

    +--+
    |  |
       |
       |
       |
       |
    =====

    HEREDOC
  end

  def print_stage_one
    puts <<-HEREDOC

    +--+
    |  |
    0  |
       |
       |
       |
    =====

    HEREDOC
  end

  def print_stage_two
    puts <<-HEREDOC

      +--+
      |  |
      0  |
     /   |
         |
         |
      =====

    HEREDOC
  end

  def print_stage_three
    puts <<-HEREDOC

      +--+
      |  |
      0  |
     /|  |
         |
         |
      =====

    HEREDOC
  end

  def print_stage_four
    puts <<-HEREDOC

      +--+
      |  |
      0  |
     /|\\ |
         |
         |
      =====

    HEREDOC
  end

  def print_stage_five
    puts <<-HEREDOC

      +--+
      |  |
      0  |
     /|\\ |
     /   |
         |
      =====

    HEREDOC
  end

  def print_stage_six
    puts <<-HEREDOC

      +--+
      |  |
      0  |
     /|\\ |
     / \\ |
         |
      =====

    HEREDOC
  end
end

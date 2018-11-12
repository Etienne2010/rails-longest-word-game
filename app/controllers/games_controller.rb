require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def initial
    session[:score] = 0
  end

  def new
    i = 0
    @letters = []
    @word = ""
    while i < 10
      ch = (rand(26) + 65).chr
      @letters.push(ch)
      @word += ch
      i += 1
    end
  end

  def score
    word = params["grid"]
    input = params["input"]
    correct = true

    # word.each_char do |grid_char|
    #   puts grid_char
    #   puts input.downcase.scan(/#{grid_char.downcase}/).count
    #   puts word.downcase.scan(/#{grid_char.downcase}/).count
    #   correct = correct && (input.downcase.scan(/grid_char.downcase/).count <= word.downcase.scan(/grid_char.downcase/).count)
    #   puts correct
    # end
    input.each_char do |grid_char|
      correct = correct && (input.downcase.scan(/#{grid_char.downcase}/).count <= word.downcase.scan(/#{grid_char.downcase}/).count)
    end
    word.each_char do |grid_char|
      correct = correct && (input.downcase.scan(/#{grid_char.downcase}/).count <= word.downcase.scan(/#{grid_char.downcase}/).count)
    end

    after_score(correct, input)
  end

  def after_score(correct, input)
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    user_serialized = open(url).read
    results = JSON.parse(user_serialized)
    if correct
      @msg = "Word can be built from grid"
    else
      @msg = "Word cannot be built from grid"
    end
    after_score2(correct, input, results)
  end

  def after_score2(correct, input, results)
    english = false
    puts results
    english = true if results["found"] == true
    @score = 0
    if english && correct
      @score = input.length
    elsif !english
      @msg += "...word is not english"
    end
    session[:score] += @score
  end
end

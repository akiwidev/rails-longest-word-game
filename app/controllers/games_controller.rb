require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    word_made_of_letters = @word.chars.all? do |letter|
      @letters.include?(letter)
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    json = open(url).read
    raise
    # if the word can't be built out of the shown letters, return "Sorry, but {word} can't be built out of {letters}"
    @result =
      unless word_made_of_letters
        "Sorry, but #{@word} can't be built out of #{@letters}"
      end

    # if the word isn't a valid English word, return "Sorry, but {word} does not seem to be a valid English word..."
    # if the word is valid, return "Congratualtions! {word} is a valid English word!"
  end
end

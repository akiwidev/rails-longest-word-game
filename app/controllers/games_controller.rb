require 'open-uri'
require 'json'

class GamesController < ApplicationController
  before_action :word_included_in_letters?, only: [:score]
  before_action :valid_word?, only: [:score]

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @message =
      if @valid == false
        "Sorry, but #{@word} does not seem to be a valid English word..."
      elsif !@included
        "Sorry, but #{@word} can't be built out of #{@letters}"
      else
        "Congratualtions! #{@word.capitalize} is a valid English word!"
      end
  end

  private

  def word_included_in_letters?
    @word = params[:word]
    @letters = params[:letters]
    @included = @word.chars.all? { |letter| @letters.include?(letter) }
  end

  def valid_word?
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    json = URI.open(url).read
    @valid = JSON.parse(json)['found']
  end
end

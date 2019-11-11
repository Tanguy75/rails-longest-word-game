require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    # display a new random grid and a form, on n a pas besoin du params car le
    # user n intervient pas
    @letters = (0...10).map { ('a'..'z').to_a.sample }
  end

  def score
    # The form will be submitted (with POST) to the score action.
    @score = params[:word]
    @letters = params[:letters]
    @english_word = english_word?(params[:word])
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    # url de l'api pour savoir si un mot est valide ou non
    json = JSON.parse(response.read)
    return json['found']
  end
end

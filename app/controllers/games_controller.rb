require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    params[:letters] = @letters
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters_token].split(' ')
    @guess_array = @guess.split('')
    @guess_array.each do |letter|
      if @letters.include?(letter) && english_word?(@guess)
        @answer = "right!"
      elsif
        @answer = "sorry, but #{@guess} cant be made with #{@letters.join(',')}"
      end
    end
    # raise
  end
end

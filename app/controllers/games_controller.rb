require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def find_word(word)
    url = "https://dictionary.lewagon.com/#{word}"
    url_serialized = URI.parse(url).read
    url_parsed = JSON.parse(url_serialized)
    return url_parsed['found']
  end

  def word_array(word, array)
    word.chars.all? { |letter| word.count(letter) <= array.to_s.count(letter) }
  end

  def score
    @word = params[:word]
    @answer = "Congradulations! #{@word} is a valid English word!"
    if find_word(@word) == false
      @answer = "Sorry but #{@word} is not a valid English word"
    elsif word_array(@word, @letters) == false
      @answer = "Sorry but #{@word} can't be built out of #{@letters.to_a}"
    end
  end
end

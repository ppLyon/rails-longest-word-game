class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @userinput = params[:user_input]
    @letters = params[:token]
    if included?(@userinput, @letters) == true && english_word?(@userinput) == true
      @result = "Congratulations #{@user} is a valid English word!"
    else
      @result = "Sorry bro, you are a looser"
    end
  end

  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    responses = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(responses.read)
    json['found']
  end
end

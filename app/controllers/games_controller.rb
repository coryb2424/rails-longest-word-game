class GamesController < ApplicationController
  LETTERS = ('A'..'Z').to_a

  def new
    @letters = Array.new(10) { LETTERS.sample }
    @start_time = Time.now
  end

  def score
    submitted_word = params['word']
    letters = params['letters'].split(' ')
    base_url = 'https://wagon-dictionary.herokuapp.com'
    start_time = params['start_time'].to_time
    end_time = params['end_time'].to_time

    reponse = JSON.parse(HTTP.get("#{base_url}/#{submitted_word}").body.to_s)
    if reponse['found']
      @message = 'Win, you found it!'
      raise
      @score = (submitted_word.size / (end_time - start_time)) * 100
    else
      @message = 'Fail, no such word'
      @score = 0
    end
  end
end

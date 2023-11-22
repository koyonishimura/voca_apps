class SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "タイトル"
      @questions = Question.looks(params[:search], params[:word])
    else
      @questions = Question.looks(params[:search], params[:word])
    end
  end
end

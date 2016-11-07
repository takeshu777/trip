class SearchController < ApplicationController
  def index
    @events = Event.text_like(params[:text]).date_between(params[:start_date],params[:end_date]).open.page(params[:page])
    @search_condition = "・開催日#{params[:start_date]}から#{params[:end_date]}まで\n・タイトルまたは概要に#{params[:text]}を含む"
  end
end


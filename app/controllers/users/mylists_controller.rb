class Users::MylistsController < ApplicationController
  before_action :find_user_events, only: [:show]

  def show
    if params[:list_name] == "attended"
      @events = @user_events.where("end_date < ?", Time.now)
    elsif params[:list_name] == "apply"
      @events = @user.events.order('id DESC')
    elsif params[:list_name] == "fav"
      @events = @user.events.order('id DESC')
    elsif params[:list_name] == "producer"
      @events = @user.events.order('id DESC')
    end
  end

  private

  def find_user_events
    @user = User.find(params[:id])
    @user_events = @user.events.order('id DESC')
  end
end

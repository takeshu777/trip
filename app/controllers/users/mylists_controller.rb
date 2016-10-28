class Users::MylistsController < ApplicationController

  def show
    @user = User.find(params[:id])
    if params[:list_name] == "attended"
      @events = @user.events.order('id DESC')
    elsif params[:list_name] == "apply"
      @events = @user.events.order('id DESC')
    elsif params[:list_name] == "fav"
      @events = @user.events.order('id DESC')
    elsif params[:list_name] == "producer"
      @events = @user.events.order('id DESC')
    end
  end

end

class Events::FavoritesController < ApplicationController

  def create
    Favorite.create(create_params)
    @event = Event.find(params[:event_id])
  end

  def destroy
    Favorite.find(params[:id]).destroy
    @event = Event.find(params[:event_id])
  end

  private
  def create_params
    params.permit(:event_id).merge(user_id: current_user.id)
  end

end

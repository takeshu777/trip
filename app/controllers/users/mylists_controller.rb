class Users::MylistsController < ApplicationController
  before_action :find_user_events, only: [:show]

  def show
    if params[:list_name] == "attended"
      @user_attend_list = @user.attends
      @events = []
      @user_attend_list.each do |attend_event|
        @event = Event.find(attend_event.event_id)
        @events << @event if @event.end_date < Time.now
      end
    elsif params[:list_name] == "apply"
      @user_attend_list = @user.attends
      @events = []
      @user_attend_list.each do |attend_event|
        @event = Event.find(attend_event.event_id)
        @events << @event if @event.start_date > Time.now
      end
    elsif params[:list_name] == "fav"
      @user_fav_list = @user.favorites
      @events = []
      @user_fav_list.each do |fav_event|
        @events << Event.find(fav_event.event_id)
      end
    elsif params[:list_name] == "producer"
      @events = @user.events.order('id DESC')
    end
    @events = Kaminari.paginate_array(@events).page(params[:page])
  end

  private

  def find_user_events
    @user = User.find(params[:id])
  end
end

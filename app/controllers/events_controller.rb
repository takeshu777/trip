class EventsController < ApplicationController

  def index
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(create_params)
    if @event.save
      flash[:notice] = "イベントが公開されました" if @event.status == 0
      flash[:notice] = "イベントを下書き保存しました" if @event.status == 1
    else
      flash[:error] = @event.errors.full_messages
      redirect_to :back and return
    end
    redirect_to root_path
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def create_params
    if params[:open].present?
      @event_status = { status: 0 }
    elsif params[:draft].present?
      @event_status = { status: 1 }
    end
    params.require(:event).permit(:title, :start_date, :end_date, :summary, :details, :status, :image, :dest).merge(user_id: current_user.id).merge(@event_status)
  end

end

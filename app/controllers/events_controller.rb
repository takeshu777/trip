class EventsController < ApplicationController

  def index
    @events = Event.order('id DESC')
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(create_params)
    if @event.save
      flash[:notice] = "企画が公開されました" if @event.status == 0
      flash[:notice] = "企画を下書き保存しました" if @event.status == 1
    else
      flash[:error] = @event.errors.full_messages
      redirect_to :back and return
    end
    redirect_to root_path
  end

  def show
    find_event_id
  end

  def edit
    find_event_id
  end

  def update
    find_event_id
    if @event.update(update_params)
      flash[:notice] = "企画が公開されました" if @event.status == 0
      flash[:notice] = "企画を下書き保存しました" if @event.status == 1
    else
      flash[:error] = @event.errors.full_messages
      redirect_to :back and return
    end
    redirect_to root_path
  end

  def destroy
    find_event_id
    if @event.destroy
      flash[:notice] = "企画を削除しました。"
    else
      flash[:error] = "企画を削除できませんでした。"
    end
    redirect_to root_path
  end


  private

  def create_params
    if params[:open].present?
      @event_status = { status: 0 }
    elsif params[:draft].present?
      @event_status = { status: 1 }
    end
    params.require(:event).permit(:title, :start_date, :end_date, :apply_start_date, :apply_end_date, :summary, :details, :status, :image, :dest).merge(user_id: current_user.id).merge(@event_status)
  end

  def update_params
    if params[:open].present?
      @event_status = { status: 0 }
    elsif params[:draft].present?
      @event_status = { status: 1 }
    end
    params.require(:event).permit(:title, :start_date, :end_date, :apply_start_date, :apply_end_date, :summary, :details, :status, :image, :dest).merge(@event_status)
  end

  def find_event_id
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "企画が見つかりませんでした。"
    redirect_to root_path
  end

end

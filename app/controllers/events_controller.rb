class EventsController < ApplicationController

  before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]

  def index
    respond_to do |format|
      format.html {
        if params[:sort].blank?
          @events = Event.order('id DESC').open.page(params[:page])
          @sort_now = "新着順"
        elsif params[:sort] == "new"
          @events = Event.order('id DESC').open.page(params[:page])
          @sort_now = "新着順"
        else
          @events = Event.order('start_date').open.page(params[:page])
          @sort_now = "開催日"
        end
        @nav_event_list = Event.apply_end_date_between(Time.now,"").order(:apply_end_date).open.limit(5)
      }
      format.js {
        if params[:new].present?
          @events = Event.order('id DESC').open.page(params[:new])
        elsif params[:start_date].present?
          @events = Event.order('start_date').open.page(params[:start_date])
        end
      }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(create_params)
    if @event.save
      redirect_to(edit_event_url(@event.id))
    else
      flash[:error] = @event.errors.full_messages
      redirect_to :back and return
    end
  end

  def show
    respond_to do |format|
      format.html {
        find_event_id
      }
      format.js {
        @event_attend_list = Event.find(params[:id]).attends.page(params[:page])
      }
    end
  end

  def edit
    find_event_id
    @details_images = DetailsImage.new
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
    @event_status = { status: 1 }
    params.require(:event).permit(:start_date, :end_date, :dest, :apply_start_date, :apply_end_date).merge(user_id: current_user.id).merge(@event_status)
  end

  def update_params
    if params[:open].present?
      @event_status = { status: 0 }
    elsif params[:draft].present?
      @event_status = { status: 1 }
    end
    params.require(:event).permit(:title, :start_date, :end_date, :apply_start_date, :apply_end_date, :summary, :details, :status, :image, :dest, :price).merge(@event_status)
  end

  def find_event_id
    @event = Event.includes(:user).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "企画が見つかりませんでした。"
    redirect_to root_path
  end

end

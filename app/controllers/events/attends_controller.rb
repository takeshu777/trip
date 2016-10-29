class Events::AttendsController < ApplicationController

  def new
    @attend = Attend.new
    find_event_id
  end

  def create
    @attend = Attend.new(create_params_attend)
    if @attend.save
      flash[:notice] = "#{Event.find(params[:event_id]).title}に申込みました。"
      redirect_to root_path
    else
      flash[:error] = @event.errors.full_messages
      redirect_to :back and return
    end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "企画が見つかりませんでした。"
      redirect_to root_path
  end

  private

  def create_params_attend
    params.require(:attend).permit(:comment).merge(user_id: current_user.id, event_id: params[:event_id] )
  end

  def find_event_id
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "企画が見つかりませんでした。"
    redirect_to root_path
  end

end

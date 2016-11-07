class Events::AttendsController < ApplicationController

  before_action :authenticate_user!, only: [:new,:create]

  def new
    @attend = Attend.new
    find_event_id
  end

  def create
    find_user
    @attend = Attend.new(create_params_attend)
    if @user.update(update_params_user) && @attend.save
      flash[:notice] = "#{Event.find(params[:event_id]).title}に申込みました。"
      redirect_to root_path
    elsif @attend.errors.present?
      flash[:error] = @attend.errors.full_messages
      redirect_to :back and return
    elsif @user.errors.present?
      flash[:error] = @user.errors.full_messages
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

  def update_params_user
    params.require(:user).permit(:f_name, :l_name, :profile, :birthday, :gender, :address_pref, :address_details, :tel)
  end

  def find_event_id
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "企画が見つかりませんでした。"
    redirect_to root_path
  end

  def find_user
    @user = User.find(current_user.id)
  end

end

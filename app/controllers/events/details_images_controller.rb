class Events::DetailsImagesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    respond_to do |format|
      format.js {
        @images = DetailsImage.new(create_params)
        if @images.save
          @file_msg = "画像アップロード完了"
          @event = Event.find(params[:event_id])
        else
          @event = Event.find(params[:event_id])
          @file_msg = "画像のアップロード失敗"
        end
      }
    end
  end

  def destroy
    DetailsImage.find(params[:id]).destroy
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.js
    end
  end

  def create_params
    params.permit(:photo, :event_id)
  end

end

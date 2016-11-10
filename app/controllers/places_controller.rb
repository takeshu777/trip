class PlacesController < ApplicationController

	def index
		@places = Place.name_reading_like(params[:searchText])
	  respond_to do |format|
			format.html { render json: @places }
	    format.json { render json: @places }
	  end
	end
end

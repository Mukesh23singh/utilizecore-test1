class SearchController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    if params[:search].present?
      @parcels = Parcel.where(unique_id: params[:search])
    else
      @parcels = []
    end
  end
end

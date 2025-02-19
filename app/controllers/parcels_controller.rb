class ParcelsController < ApplicationController
  before_action :authenticate_user!, :except => [:new, :create, :show]
  before_action :set_parcel, only: %i[ show edit update destroy ]

  # GET /parcels or /parcels.json
  def index
    @parcels = Parcel.all
  end

  # GET /parcels/1 or /parcels/1.json
  def show
  end

  # GET /parcels/new
  def new
    @parcel = Parcel.new
    users_and_service_types
  end

  # GET /parcels/1/edit
  def edit
    users_and_service_types
  end

  # POST /parcels or /parcels.json
  def create
    @parcel = Parcel.new(parcel_params)

    respond_to do |format|
      if @parcel.save
        format.html { redirect_to @parcel, notice: 'Parcel was successfully created.' }
        format.json { render :show, status: :created, location: @parcel }
      else
        format.html do
          users_and_service_types
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @parcel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parcels/1 or /parcels/1.json
  def update
    respond_to do |format|
      if @parcel.update(parcel_params)
        format.html { redirect_to @parcel, notice: 'Parcel was successfully updated.' }
        format.json { render :show, status: :ok, location: @parcel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parcel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parcels/1 or /parcels/1.json
  def destroy
    @parcel.destroy
    respond_to do |format|
      format.html { redirect_to parcels_url, notice: 'Parcel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report
    send_file "#{Rails.root}/public/data.xlsx"
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def users_and_service_types
      @users = User.includes(:address).all.map{|user| [user.name_with_address, user.id] if user.address && user.name != 'admin'}.compact
      @service_types = ServiceType.all.map{|service_type| [service_type.name, service_type.id]}
    end

    def set_parcel
      @parcel = Parcel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parcel_params
      params.require(:parcel).permit(:weight, :status, :service_type_id,
                                     :payment_mode, :sender_id, :receiver_id,
                                     :cost)
    end
end

class Admin::VehiclesController < Admin::BaseController
  before_action :set_vehicle, only: %i[ show edit update destroy ]

  # GET /admin/vehicles
  def index
    @vehicles = Vehicle.order(published_on: :desc, created_at: :desc)
  end

  # GET /admin/vehicles/1
  def show
  end

  # GET /admin/vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /admin/vehicles/1/edit
  def edit
  end

  # POST /admin/vehicles
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      redirect_to admin_vehicle_path(@vehicle), notice: "Vehicle was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /admin/vehicles/1
  def update
    if @vehicle.update(vehicle_params)
      redirect_to admin_vehicle_path(@vehicle), notice: "Vehicle was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /admin/vehicles/1
  def destroy
    @vehicle.destroy!
    redirect_to admin_vehicles_url, notice: "Vehicle was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit(
        :external_id,
        :title,
        :marca,
        :modelo,
        :ano,
        :preco,
        :km,
        :descricao,
        :importada,
        :destaque,
        :estado,
        :published_on,
        :photo
      )
    end
end

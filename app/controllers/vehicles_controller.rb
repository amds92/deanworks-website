class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.order(published_on: :desc, created_at: :desc).page(params[:page]).per(9)
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end
end

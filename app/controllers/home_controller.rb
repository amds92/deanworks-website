class HomeController < ApplicationController
  def index
    @featured_vehicles = Vehicle.where(destaque: true).where.not(estado: Vehicle.estados[:sold]).order(published_on: :desc, created_at: :desc).limit(3)

    @vehicles = Vehicle.where.not(estado: Vehicle.estados[:sold]).order(published_on: :desc, created_at: :desc).limit(12)
    @works = Work.order(published_on: :desc, created_at: :desc).limit(3)

    @vehicles_count = Vehicle.where.not(estado: Vehicle.estados[:sold]).count
  end
end

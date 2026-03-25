class WorksController < ApplicationController
  def index
    @works = Work.order(published_on: :desc, created_at: :desc).page(params[:page]).per(9)
  end

  def show
    @work = Work.find(params[:id])
  end
end

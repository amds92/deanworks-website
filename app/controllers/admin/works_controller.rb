class Admin::WorksController < Admin::BaseController
  before_action :set_work, only: %i[ show edit update destroy ]

  # GET /admin/works
  def index
    @works = Work.order(published_on: :desc, created_at: :desc)
  end

  # GET /admin/works/1
  def show
  end

  # GET /admin/works/new
  def new
    @work = Work.new
  end

  # GET /admin/works/1/edit
  def edit
  end

  # POST /admin/works
  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to admin_work_path(@work), notice: "Work was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /admin/works/1
  def update
    if @work.update(work_params)
      redirect_to admin_work_path(@work), notice: "Work was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /admin/works/1
  def destroy
    @work.destroy!
    redirect_to admin_works_url, notice: "Work was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def work_params
      params.require(:work).permit(
        :external_id,
        :titulo,
        :tipo,
        :pedido_cliente,
        :solucao,
        :resultado,
        :published_on,
        :photo
      )
    end
end

class Admin::NoticesController < Admin::AdminController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]

  # GET /notices
  # GET /notices.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @notices = Notice.order('id desc').page(params[:page]).per(params[:per_page])
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
  end

  # GET /notices/new
  def new
    @notice = Notice.new
    @notice.build_notice_content
  end

  # GET /notices/1/edit
  def edit
  end

  # POST /notices
  # POST /notices.json
  def create
    @admin_notice = Notice.new(notice_params)

    respond_to do |format|
      if @admin_notice.save
        format.html { redirect_to admin_notice_path(@admin_notice), notice: @controller_name +t(:message_success_create)}
        format.json { render action: 'show', status: :created, location: @admin_notice }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notices/1
  # PATCH/PUT /notices/1.json
  def update
    respond_to do |format|
      if @admin_notice.update(notice_params)
        format.html { redirect_to admin_notice_path(@admin_notice), notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    @admin_notice.destroy
    respond_to do |format|
      format.html { redirect_to admin_notices_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_notice
    @admin_notice = Notice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def notice_params
    params.require(:notice).permit(:id,:title,:count,notice_content_attributes: [:id,:content]).merge(user_id: current_admin.id)
  end
end

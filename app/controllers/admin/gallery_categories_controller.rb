class Admin::GalleryCategoriesController < Admin::AdminController
  before_action :set_admin_gallery_category, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_gallery,scope:[:admin_menu])
    @controller_name = t('activerecord.models.gallery_category')
  end

  # GET /admin/gallery_categories
  # GET /admin/gallery_categories.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_gallery_categories = GalleryCategory.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admin_gallery_categories }
    end
  end

  # GET /admin/gallery_categories/1
  # GET /admin/gallery_categories/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @admin_gallery_category }
    end
  end

  # GET /admin/gallery_categories/new
  # GET /admin/gallery_categories/new.json
  def new
    @admin_gallery_category = GalleryCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @admin_gallery_category }
    end
  end

  # GET /admin/gallery_categories/1/edit
  def edit
  end

  # POST /admin/gallery_categories
  # POST /admin/gallery_categories.json
  def create
    @admin_gallery_category = GalleryCategory.new(admin_gallery_category_params)

    respond_to do |format|
      if @admin_gallery_category.save
        format.html { redirect_to admin_gallery_category_path(@admin_gallery_category), notice: @controller_name +t(:message_success_create)}
        format.json { render :json => @admin_gallery_category, :status => :created, :location => @admin_gallery_category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @admin_gallery_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/gallery_categories/1
  # PUT /admin/gallery_categories/1.json
  def update
    respond_to do |format|
      if @admin_gallery_category.update_attributes(admin_gallery_category_params)
        format.html { redirect_to admin_gallery_category_path(@admin_gallery_category), notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @admin_gallery_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/gallery_categories/1
  # DELETE /admin/gallery_categories/1.json
  def destroy
    @admin_gallery_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_gallery_categories_url }
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_gallery_category
    @admin_gallery_category = GalleryCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_gallery_category_params
    params.require(:gallery_category).permit(:gallery_category_id,:title,:enable).merge(user_id: current_admin.id)
  end
end

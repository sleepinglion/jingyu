class Admin::GalleriesController < Admin::AdminController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]

  # GET /galleries
  # GET /galleries.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    category_condition = {enable: true}

    @gallery_categories = GalleryCategory.where(category_condition)

    if params[:category].present?
      @gallery_category = GalleryCategory.find(params[:category])
    end

    condition = { }

    if @gallery_category.present?
      condition[:gallery_category_id] = @gallery_category.id
    end

    @gallery_count = Gallery.where(condition).count
    @galleries = Gallery.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @gallery = Gallery.new
    @gallery_categories=GalleryCategory.all
    @gallery_category_id=params[:gallery_category_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
    @gallery_categories=GalleryCategory.all
    @gallery_category_id=@gallery.gallery_category.id
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to admin_gallery_url(@gallery), notice: @controller_name +t(:message_success_create)}
        format.json { render :json => @gallery, :status => :created, :location => @gallery }
      else
        format.html { render :action => "new" }
        format.json { render :json => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update_attributes(gallery_params)
        format.html { redirect_to admin_galleries_url, notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to admin_galleries_url }
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gallery_params
    params.require(:gallery).permit(:id,:gallery_category_id,:title,:photo,:content).merge(user_id: current_admin.id)
  end
end

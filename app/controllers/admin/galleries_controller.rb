class Admin::GalleriesController < Admin::AdminController
  before_action :set_admin_gallery, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_gallery,scope:[:admin_menu])
    @controller_name = t('activerecord.models.gallery')
  end

  # GET /galleries
  # GET /galleries.json
  def index
    if params[:gallery_category_id]
      @admin_galleries = Gallery.where(:gallery_category_id=> params[:gallery_category_id]).order('id desc').page(params[:page]).per(15)
    else
      @admin_galleries = Gallery.order('id desc').page(params[:page]).per(15)
    end

    @script='galleries'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admin_galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @admin_gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @admin_gallery = Gallery.new
    @admin_gallery_categories=GalleryCategory.all
    @admin_gallery_category_id=params[:gallery_category_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @admin_gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
    @admin_gallery_categories=GalleryCategory.all
    @admin_gallery_category_id=@admin_gallery.gallery_category.id
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(admin_gallery_params)

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
      if @admin_gallery.update_attributes(admin_gallery_params)
        format.html { redirect_to admin_galleries_url, notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @admin_gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @admin_gallery.destroy

    respond_to do |format|
      format.html { redirect_to admin_galleries_url }
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_gallery
    @admin_gallery = Gallery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_gallery_params
    params.require(:gallery).permit(:id,:gallery_category_id,:title,:photo,:content).merge(user_id: current_admin.id)
  end
end

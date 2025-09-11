class GalleriesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)
    @controller_name = t('activerecord.models.gallery')
    @title = t('activerecord.models.gallery')
    @meta_description = t(:meta_description_gallery)
  end

  # GET /galleries
  # GET /galleries.json
  def index
    @gallery_categories = GalleryCategory.all

    if (params[:gallery_category_id])
      @gallery_category_id = params[:gallery_category_id].to_i
    else
      @gallery_category_id = @gallery_categories[0].id
    end

    @galleries = Gallery.where(:gallery_category_id => @gallery_category_id).order(:id => 'desc').page(params[:page]).per(30)

    if (params[:id])
      @gallery = Gallery.find(params[:id])
    else
      @gallery = @galleries[0]
    end

    if @gallery
      @title = @gallery.title
      @meta_description = @gallery.content
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    @gallery_categories = GalleryCategory.all
    @gallery_category_id = @gallery.gallery_category_id
    @galleries = Gallery.where(:gallery_category_id => @gallery_category_id).order(:id => 'desc').page(params[:page]).per(30)

    if @gallery
      @title = @gallery.title
      @meta_description = @gallery.content
    end
  end

  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @gallery = Gallery.new
    @gallery_categories = GalleryCategory.all
    if (params[:gallery_category_id])
      @gallery_category_id = params[:gallery_category_id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
    @gallery_categories = GalleryCategory.all
    @gallery_category_id = @gallery.gallery_category.id
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to gallery_url(@gallery), :notice => @controller_name + t(:message_success_create) }
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
        format.html { redirect_to gallery_url(@gallery), :notice => @controller_name + t(:message_success_update) }
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
      format.html { redirect_to galleries_url(:gallery_category_id => @gallery.gallery_category_id) }
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
    params.require(:gallery).permit(:id, :gallery_category_id, :title, :photo, :photo_cache, :content).merge(user_id: current_user.id)
  end
end

class BlogCategoryController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_blog_category, only: [:show, :edit, :update, :destroy]

  def initialize
    super
    @controller_name=t('activerecord.models.notice')
  end

  # GET /blog_categories
  # GET /blog_categories.json
  def index
    @blog_categories = BlogCategory.order(@menu_setting.order).page(params[:page]).per(@menu_setting.per)

    respond_to do |format|
      format.html
      format.json { render json: @blog_categories }
    end
  end

  # GET /blog_categories/1
  # GET /blog_categories/1.json
  def show
  end

  # GET /blog_categories/new
  def new
    @blog_category = BlogCategory.new
    @blog_category.build_notice_content
  end

  # GET /blog_categories/1/edit
  def edit
  end

  # POST /blog_categories
  # POST /blog_categories.json
  def create
    @blog_category = BlogCategory.new(notice_params)
    @blog_category.user_id=current_user.id

    respond_to do |format|
      if @blog_category.save
        format.html { redirect_to @blog_category, notice: @controller_name +t(:message_success_create)}
        format.json { render action: 'show', status: :created, location: @blog_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog_categories/1
  # PATCH/PUT /blog_categories/1.json
  def update
    respond_to do |format|
      if @blog_category.update(notice_params)
        format.html { redirect_to @blog_category, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_categories/1
  # DELETE /blog_categories/1.json
  def destroy
    @blog_category.destroy
    respond_to do |format|
      format.html { redirect_to notices_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blog_category
    @blog_category = BlogCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_category_params
    params.require(:blog_category).permit(:id,:blog_category_id,:blog_categories_count,:title)
  end
end

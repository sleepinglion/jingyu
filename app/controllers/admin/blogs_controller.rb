class Admin::BlogsController < Admin::AdminController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    category_condition = {enable: true}

    @blog_categories = BlogCategory.where(category_condition)

    if params[:category].present?
      @blog_category = BlogCategory.find(params[:category])
    end

    condition = { }

    if @blog_category.present?
      condition[:blog_category_id] = @blog_category.id
    end

    @blog_count = Blog.where(condition).count
    @blogs = Blog.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @blog.build_blog_picture
  end

  # GET /blogs/1/edit
  def edit
    unless @blog.blog_picture.present?
      @blog.build_blog_picture
    end
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to [:admin, @blog], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @blog }
      else
        @blog.build_blog_picture

        format.html { render action: 'new' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to [:admin, @blog], notice: t(:message_success_update) }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to admin_blogs_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:blog).permit(:blog_category_id, :user_id, :title, :content, :enable, blog_picture_attributes: [:picture])
  end
end

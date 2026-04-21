class BlogsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blog_categories = BlogCategory.where(enable: true)

    if params[:blog_category_id]
      @blog_category = BlogCategory.find(params[:blog_category_id])
      @title = t('activerecord.models.blog')+" > #{@blog_category.title}"
      @meta_description = "#{@blog_category.title} 카테고리 글 목록입니다. #{t(:meta_description_blog)}"
      @blogs = Blog.where(blog_category_id: @blog_category.id).order(id: :desc).page(params[:page]).per(15)
    else
      @title = t('activerecord.models.blog')
      @meta_description = t(:meta_description_blog)
      @blogs = Blog.order(id: :desc).page(params[:page]).per(15)
    end

    @template = '/blogs/index_default'

    respond_to do |format|
      format.html { render @template }
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @comment  = Comment.build_from(@blog, current_user, "")
    @blog_categories = BlogCategory.where(enable: true)

    @meta_description = @blog.description.presence || t(:meta_description_blog)
    @title=@blog.title

    if params[:blog_category_id]
      @blog_category = BlogCategory.find(params[:blog_category_id])
    end

    @related_blogs = Blog.joins(:tags)
                         .where(tags: { id: @blog.tags.ids })
                         .where.not(id: @blog.id)
                         .distinct
                         .limit(5)

    set_meta_tags canonical: blog_url(@blog)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @blog_comments }
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @blog.build_blog_picture
    if params[:blog_category_id]
      @blog_category=params[:blog_category_id]
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog_category=@blog.blog_category_id
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: @controller_name +t(:message_success_create)}
        format.json { render action: 'show', status: :created, location: @blog }
      else
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
        format.html { redirect_to @blog, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
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
      format.html { redirect_to blogs_url }
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
    params.require(:blog).permit(:blog_category_id, :title, :description, :tag_list, :content).merge(user_id: current_user.id)
  end
end

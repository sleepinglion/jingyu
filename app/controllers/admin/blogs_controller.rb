class Admin::BlogsController < Admin::AdminController
  before_action :set_admin_blog, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_blog,scope:[:admin_menu])
    @controller_name = t('activerecord.models.blog')
  end

  # GET /blogs
  # GET /blogs.json
  def index
      params[:per_page] = 10 unless params[:per_page].present?

      @admin_blog_categories=BlogCategory.where(:enable=>true)

      if(params[:blog_category_id])
        @admin_blog_category_id=params[:blog_category_id].to_i
        @admin_blogs = Blog.where(:blog_category_id=>@admin_blog_category_id).order(id:'desc').page(params[:page]).per(params[:per_page])
      else
        @admin_blogs = Blog.order('id desc').page(params[:page]).per(params[:per_page])
      end

    respond_to do |format|
      format.html
      format.json { render json: @admin_blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
   @admin_blog_comments=@admin_blog.blog_comment.order('id desc').page(params[:page]).per(10)
   @admin_blog_comment=BlogComment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @admin_blog_comments }
    end
  end

  # GET /blogs/new
  def new
    @admin_blog = Blog.new
    @admin_blog.build_blog_content
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @admin_blog = Blog.new(admin_blog_params)

    respond_to do |format|
      if @admin_blog.save
        format.html { redirect_to admin_blogs_url, notice: @controller_name +t(:message_success_create)}
        format.json { render action: 'show', status: :created, location: @admin_blog }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @admin_blog.update(admin_blog_params)
        format.html { redirect_to admin_blogs_url, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @admin_blog.destroy
    respond_to do |format|
      format.html { redirect_to admin_blogs_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_blog
    @admin_blog = Blog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_blog_params
    params.require(:blog).permit(:blog_category_id, :user_id, :title, :description,:count, :photo, :photo_cache, blog_content_attributes: [:id,:content]).merge(user_id: current_admin.id)
  end
end

class Admin::BlogCategoriesController < Admin::AdminController
  before_action :set_blog_category, only: [:show, :edit, :update, :destroy]

  # GET /admin/gallery_categories
  # GET /admin/gallery_categories.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @blog_category_count = BlogCategory.count
    @blog_categories = BlogCategory.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @blog_category }
    end
  end

  # GET /admin/blog_categories/1
  # GET /admin/blog_categories/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog_category }
    end
  end

  # GET /admin/blog_categories/new
  # GET /admin/blog_categories/new.json
  def new
    @admin_blog_category = BlogCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog_category }
    end
  end

  # GET /admin/blog_categories/1/edit
  def edit
  end

  # POST /admin/blog_categories
  # POST /admin/blog_categories.json
  def create
    @blog_category = BlogCategory.new(blog_category_params)

    respond_to do |format|
      if @blog_category.save
        format.html { redirect_to admin_blog_category_path(@blog_category), notice: @controller_name +t(:message_success_create)}
        format.json { render json: @blog_category, status: :created, location: @blog_category }
      else
        format.html { render action: "new" }
        format.json { render json: @blog_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/blog_categories/1
  # PUT /admin/blog_categories/1.json
  def update
    respond_to do |format|
      if @blog_category.update(blog_category_params)
        format.html { redirect_to admin_blog_category_path(@blog_category), notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/blog_categories/1
  # DELETE /admin/blog_categories/1.json
  def destroy
    @blog_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_blog_categories_url }
      format.json { head :ok }
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_category
      @blog_category = BlogCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_category_params
      params.require(:blog_category).permit(:blog_category_id,:title,:enable)
    end
end

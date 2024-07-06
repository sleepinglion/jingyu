class TagsController < BoardController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    if params[:tag].present?

      if params[:search_detail].present?
        session[:search_detail]=1
      else
        if params[:search_summary].present?
          session.delete(:search_detail)
        end
      end

      if params[:list_type].present?
        if params[:list_type]=='list'
          session[:talk_list_type]='list'
        else
          session[:talk_list_type]='module'
        end
      end

      params[:per_page] = 12 unless params[:per_page].present?

      @blog_categories=BlogCategory.where(:enable=>true)
      @blog_count  =  Blog.tagged_with(params[:tag]).count
      @blogs = Blog.tagged_with(params[:tag]).page(params[:page]).per(params[:per_page])
      # @blogs = Blog.tagged_with(params[:tag]).page(params[:page]).per(15)
      #@blog_categories=BlogCategory.where(:leaf=>true).where(:enable=>true)
      @meta_keywords=params[:tag]+','+t(:meta_keywords)
    else
      @blog_count=0
    end
  end

  def default_render
    render "/blogs/#{action_name.to_s}"
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tag_params
    params.require(:tag).permit(:id,:title,tag_content_attributes: [:content])
  end
end

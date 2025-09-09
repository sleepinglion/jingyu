class FaqCategoriesController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_faq_category, only: [:show]

  # GET /faq_categories
  # GET /faq_categories.json
  def index
    @faq_categories = FaqCategory.order('id desc').page(params[:page]).per(10)
    @script='board/faqs/index'

    respond_to do |format|
      format.html # _slide.html.erb
      format.json { render json: @faq_categories }
    end
  end

  # GET /faq_categories/1
  # GET /faq_categories/1.json
  def show
    respond_to do |format|
      format.html # _show.html.erb
      format.json { render json: @faq_category }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faq_category
      @faq_category = FaqCategory.find(params[:id])
    end
end

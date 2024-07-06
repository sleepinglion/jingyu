class IntroController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.intro')
    
    @title=t('activerecord.models.intro')+t(:title_separator)+t(:application_name)
    @meta_description=t(:meta_description_intro)
    @page_itemtype="http://schema.org/ProfilePage"
  end

  # GET /intro
  # GET /intro.json
  def index
    # @intro=Intro.page(params[:page]).per(15)
    @user=User.find(1)
    @histories=History.page(params[:page]).per(15)

    @script='intro'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user }
    end
  end
end

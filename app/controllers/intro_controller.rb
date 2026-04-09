class IntroController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]

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

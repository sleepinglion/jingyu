class QuestionsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.question')
    @title=t('activerecord.models.question')
    @meta_description=t(:meta_description_question)
    @page_itemtype="http://schema.org/QAPage"
  end

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.order(id:'desc').page(params[:page]).per(15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @comment  = Comment.build_from(@question, current_user, "")

    @script="board/show"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
    @script="board/new"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @question }
    end
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    if current_user
      @question.user_id=current_user.id
    end

    respond_to do |format|
      if Rails.env.production?
        if current_user
          result=@question.save
        else
          result=verify_recaptcha(:model => @question, :message => "Oh! It's error with reCAPTCHA!") && @question.save
        end
      else
        result=@question.save
      end

      if result
        session[@question.class.name]||={}
        session[@question.class.name][:guest_pass_id]||=[]
        session[@question.class.name][:guest_pass_id]<<@question.id
        format.html { redirect_to @question, :notice=> @controller_name +t(:message_success_create)}
        format.json { render :json => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update_attributes(question_params)
        format.html { redirect_to @question, :notice=> @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :ok }
    end
  end

  def get_gg
    return set_question
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:user_id,:title,:name,:password, :content).merge(:user_id=>current_user)
  end
end

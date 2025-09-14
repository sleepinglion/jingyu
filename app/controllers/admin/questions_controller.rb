class Admin::QuestionsController < Admin::AdminController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @question_count = Question.count
    @questions = Question.page(params[:page]).per(params[:per_page]).order('id desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /admin/questions/1
  # GET /admin/questions/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @question_answers }
    end
  end

  # GET /admin/questions/new
  # GET /admin/questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @question }
    end
  end

  # GET /admin/questions/1/edit
  def edit
  end

  # POST /admin/questions
  # POST /admin/questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to admin_question_path(@question), notice: @controller_name +t(:message_success_create)}
        format.json { render :json => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/questions/1
  # PUT /admin/questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/questions/1
  # DELETE /admin/questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_admin_questions_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:id,:title,:count,question_content_attributes: [:id,:content]).merge(user_id: current_admin.id)
  end
end

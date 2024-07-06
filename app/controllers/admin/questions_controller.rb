class Admin::QuestionsController < Admin::AdminController
  before_action :set_admin_question, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.question')
  end

  # GET /admin/questions
  # GET /admin/questions.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_questions = Question.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admin_questions }
    end
  end

  # GET /admin/questions/1
  # GET /admin/questions/1.json
  def show
    @admin_question_answers=@admin_question.question_comment.order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @admin_question }
    end
  end

  # GET /admin/questions/new
  # GET /admin/questions/new.json
  def new
    @admin_question = Question.new
    @admin_question.build_question_content

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @admin_question }
    end
  end

  # GET /admin/questions/1/edit
  def edit
  end

  # POST /admin/questions
  # POST /admin/questions.json
  def create
    @admin_question = Question.new(admin_question_params)

    respond_to do |format|
      if @admin_question.save
        format.html { redirect_to admin_question_path(@admin_question), notice: @controller_name +t(:message_success_create)}
        format.json { render :json => @admin_question, :status => :created, :location => @admin_question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @admin_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/questions/1
  # PUT /admin/questions/1.json
  def update
    respond_to do |format|
      if @admin_question.update_attributes(admin_question_params)
        format.html { redirect_to @admin_question, notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @admin_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/questions/1
  # DELETE /admin/questions/1.json
  def destroy
    @admin_question.destroy
    respond_to do |format|
      format.html { redirect_to admin_admin_questions_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_question
    @admin_question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_question_params
    params.require(:question).permit(:id,:title,:count,question_content_attributes: [:id,:content]).merge(user_id: current_admin.id)
  end
end

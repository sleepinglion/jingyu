class Admin::GuestBooksController < Admin::AdminController
  before_action :set_guest_book, only: [:show, :edit, :update, :destroy]

  # GET /guest_books
  # GET /guest_books.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @guest_book_count = GuestBook.count
    @guest_books = GuestBook.page(params[:page]).per(params[:per_page]).order('id desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guest_books }
    end
  end

  # GET /guest_books/1
  # GET /guest_books/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @guest_book }
    end
  end

  # GET /guest_books/new
  # GET /guest_books/new.json
  def new
    @guest_book = GuestBook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @guest_book }
    end
  end

  # GET /guest_books/1/edit
  def edit
  end

  # POST /guest_books
  # POST /guest_books.json
  def create
    @guest_book = GuestBook.new(guest_book_params)

    respond_to do |format|
      if @guest_book.save
        format.html { redirect_to admin_guest_book_path(@guest_book), notice: @controller_name +t(:message_success_create)}
        format.json { render :json => @guest_book, :status => :created, :location => @admin_guest_book }
      else
        format.html { render :action => "new" }
        format.json { render :json => @guest_book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /guest_books/1
  # PUT /guest_books/1.json
  def update
    respond_to do |format|
      if @guest_book.update_attributes(guest_book_params)
        format.html { redirect_to admin_guest_book_path(@guest_book), notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @guest_book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /guest_books/1
  # DELETE /guest_books/1.json
  def destroy
    @guest_book.destroy

    respond_to do |format|
      format.html { redirect_to admin_guest_books_url }
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_guest_book
    @guest_book = GuestBook.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def guest_book_params
    params.require(:guest_book).permit(:id,:name,:password,:count,:title,guest_book_content_attributes: [:id,:content],guest_book_comment_attributes: [:id,:content]).merge(user_id: current_admin.id)
  end
end

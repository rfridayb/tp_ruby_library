class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy borrow return ]

  # GET /books or /books.json
  def index
    if params[:query] && params[:query] != ""
      @query = params[:query]
      @books = Book.all.where('books.title LIKE :q OR books.author LIKE :q', q:'%'+@query+'%')
    else
      @books = Book.all
    end
  end

  # GET /books/1 or /books/1.json
  def show
    @borrow = Borrow.where(user_id: current_user.id, book_id: @book.id).order(started_at: :desc).first
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def borrow
    if !@book.borrowed?
      Borrow.create(book_id: @book.id, user_id: current_user.id,started_at: Time.now)
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Book was successfully borrowed." }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to books_url, notice: "This book is already borrowed." }
        format.json { head :unprocessable_entity }
      end
    end
  end
  
  def return
    unless @book.borrowed?
      respond_to do |format|
        format.html { redirect_to books_url, notice: "This book is not currently borrowed." }
        format.json { head :unprocessable_entity }
      end
    end
    @borrow = Borrow.find_by(book_id: @book.id,user_id: current_user, ended_at: nil)
    if !@borrow.nil?
      if @borrow.update(ended_at: DateTime.now)
        respond_to do |format|
          format.html { redirect_to books_url, notice: "Book was successfully borrowed." }
          format.json { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to books_url, notice: "Something went wrong." }
          format.json { head :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to books_url, notice: "This book can't be returned. Either it is not currently borrowed or it is not borrowed by this user." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :publication_year)
    end
end

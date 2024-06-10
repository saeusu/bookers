class BooksController < ApplicationController
  def new
    # @book = Book.new
    # @books = Book.all
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to @book
    else
      @error_messages = @book.errors.full_messages
      @books = Book.all
      flash.now[:error] = @error_messages
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    flash.now[:notice] = "errors prohibited this book from being saved:" if @book.errors.any?
  end

  def show
    @book = Book.find(params[:id]) #これ使えるかも
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully deleted."
    redirect_to '/books'
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
      redirect_to @book
    else
      @error_messages = @book.errors.full_messages
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

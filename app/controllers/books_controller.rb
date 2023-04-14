class BooksController < ApplicationController

  def new
  end

  def index
    @book_new = Book.new
    @books = Book.all
  end

  def create
    @user = current_user
    @books = Book.all
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
     flash[:notice] ="You have created book successfully."
     redirect_to book_path(@book_new.id)
    else
     render :index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit

    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to "/books"
    end

    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to book_path(@book.id)
    else
     render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to "/books"
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end


end
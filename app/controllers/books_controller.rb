class BooksController < ApplicationController
  def new
     @book = Book.new
  end
  def show
     @books = Book.find(params[:id])
     @user = @books.user
     @book = Book.new
  end

  def index
      @books = Book.all.order(id: :asc)
      @book = Book.new
      @user = current_user
  end

  def edit
     @book = Book.find(params[:id])
     unless @book.user.id == current_user.id
     redirect_to books_path
     end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
    flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book.id)
   else
    @books = Book.all.order(id: :asc)
    @user = current_user
    render :index
   end
  end

  def update
     @book = Book.find(params[:id])
     unless @book.user.id == current_user.id
     redirect_to books_path
     end
     if @book.update(book_params)
     flash[:notice] = "Book was successfully updated."
     redirect_to book_path(@book.id)
     else
     @books = Book.all.order(id: :asc)
     render :edit
     end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

end
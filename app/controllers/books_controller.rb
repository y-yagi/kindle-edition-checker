class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = current_user.books.order(:created_at)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.build(book_params, current_user)

    if @book.save
      redirect_to books_url, notice: "「#{@book.title}」を登録しました"
    else
      render :new
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: "「#{@book.title}」を削除しました"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn_10)
    end
end

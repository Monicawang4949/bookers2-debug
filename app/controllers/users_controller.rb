class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
    @book_comment = BookComment.new
    @today_book = @user.books.created_today
    @yesterday_book = @user.books.created_yesterday
    @this_week_book = @user.books.created_this_week
    @last_week_book = @user.books.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def posts_on_date
    user = User.includes(:books).find(params[:user_id])
    @books = user.books.where(created_at: params[:created_at].to_date.all_day)
    render :posts_on_date_form
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

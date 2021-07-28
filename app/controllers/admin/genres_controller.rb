class Admin::GenresController < ApplicationController
  before_action :if_not_admin

  def index
     @genres = Genre.page(params[:page]).per(10).order("name")
     @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to admin_genres_path
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def if_not_admin
    redirect_to user_path unless current_user.admin?
  end

end

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
   @top_rated_foodplaces = Foodplace.where("google_rating >= 4").limit(10)
  end

  def profile
    @user = User.find(params[:id])
    @favorites = @user.all_favorites
    @saves = @user.all_saves
    @visits = @user.all_visits
    @followers = @user.all_follows
    @followings = @user.all_following
  end

  def users
    @users = User.where.not(id: current_user.id)
    # @user = User.find(params[:id])
    if params[:query].present?
      @users = User.where("nickname ILIKE ?", "%#{params[:query]}%")
    else
      @users = User.all
    end
  end
end

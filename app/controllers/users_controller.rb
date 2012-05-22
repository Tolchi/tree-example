class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :only_allow_admin, :only => [ :index ]

  def index
    authorize! :index, @user, :message => 'not authorized as an admin'
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def only_allow_admin
    redirect_to root_path, :alert => "Not authorized as an administrator." unless current_user.has_role? :admin
  end

end

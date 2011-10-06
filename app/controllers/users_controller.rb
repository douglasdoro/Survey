class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find current_user.id
  end

  def update
    @user = User.find current_user.id
    @user.update_attributes params[:user]
    redirect_to @user, :notice => "Perfil atualizado com sucesso."
  end

end

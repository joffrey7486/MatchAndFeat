class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Votre Profil a bien été édité"
      redirect_to @user
    else
      flash[:warning] = "Il y a eu un problème lors de la modification de votre Profil."
      render 'edit'
    end
  end

  def destroy
    @user.avatar.purge
    flash[:success] = 'Votre Avatar a bien été supprimé.'
    redirect_to @user
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end   

  def users_params
    params.require(:user).permit(:avatar, :user_name, :social_link_1, :social_link_2)
  end
end

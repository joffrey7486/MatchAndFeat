class UserMailer < ApplicationMailer
  default from: 'matchandfeathp@gmail.com'
 
  def welcome_email(user)
    @user = user 
    @url  = 'https://matchandfeathp.herokuapp.com/Mon_Profil/sign_in' 
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def create_project_email(project)
    @project = project
    @url = 'https://matchandfeathp.herokuapp.com/Mon_Profil/sign_in'
    mail(to: @project.user.email, subject: 'Création du projet')
  end

  def new_feat_email(feat)
    @feat = feat
    @url = 'https://matchandfeathp.herokuapp.com/Mon_Profil/sign_in'
    mail(to: @feat.user.email, subject: 'Nouvelle collaboration')
  end
end

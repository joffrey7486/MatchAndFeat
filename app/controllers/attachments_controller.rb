class AttachmentsController < ApplicationController
  before_action :require_login
  before_action :set_attachment
  before_action :ownership_verification

  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    filename = @attachment.filename
    @attachment.purge
    flash[:info] = "Le fichier #{filename} a bien été supprimé."
    redirect_back fallback_location: root_path
  end

  private

  def set_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end

  def ownership_verification
    if @attachment.record_type == "Project"
      owner = Project.find(@attachment.record_id).user
    elsif @attachment.record_type == "Feat"
      owner = Feat.find(@attachment.record_id).user
    end
    unless owner == current_user || current_user.status == "admin"
      flash[:danger] = "L'accès à cette page est restreint."
      redirect_to root_path
    end
  end
end

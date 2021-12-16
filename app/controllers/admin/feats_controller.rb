module Admin
  class FeatsController < ApplicationController
    before_action :set_feat, except: [:index, :new, :create]

    def index
      @feats = Project.find(params[:project_id]).feats.order(id: :desc)
      @project = Project.find(params[:project_id])
    end

    def show
    end

    def new
      @feat = Feat.new
    end

    def create
      @feat = Feat.new(feat_params)
      @feat.user = current_user
      @feat.project = Project.find(params[:project_id])

      if @feat.save
        flash[:success] = "Votre Feat a bien été publié !"
        redirect_to project_path(params[:project_id])
      else
        flash[:warning] = "Il y eu un problème lors de la création de votre Feat."
        redirect_to project_path(params[:project_id])
      end
    end

    def edit
    end

    def update
        if @feat.update_attributes(feat_params)
          flash[:success] = "Votre Feat a bien été édité"
          redirect_to admin_project_feats_path(@feat.project)
        else
          flash[:warning] = "Il y a eu un problème lors de la modification de votre Feat."
          render 'edit'
        end
    end

    def destroy
      if @feat.destroy
        flash[:success] = 'Votre Feat a bien été supprimé.'
        redirect_to edit_admin_project_path(params[:project_id])
      else
        flash[:warning] = 'Il y a eu un problème lors de la suppression de votre Feat.'
        redirect_to @feat
      end
    end

    private

    def feat_params
      params.require(:feat).permit(:title, :description, attachements: [])
    end

    def set_feat
      @feat = Feat.find(params[:id])
    end
  end
end

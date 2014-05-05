class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  def index
    @projects = Project.all    
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Project has been created."
    else
      flash[:danger] = "Project has not been created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to @project, notice: "Project has been updated"
    else
      flash[:danger] = "Project has not been updated."
      render :edit
    end
  end

  def destroy
    @project.destroy

    redirect_to root_path, notice: "Project has been destroyed."
  end

  private
  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = "The project you were looking for could not be found."
    redirect_to projects_path
  end
end

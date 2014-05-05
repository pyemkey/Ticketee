class ProjectsController < ApplicationController
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
   @project = Project.find(params[:id]) 
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to @project, notice: "Project has been updated"
    else
      flash[:danger] = "Project has not been updated."
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to root_path, notice: "Project has been destroyed."
  end

  private
  def project_params
    params.require(:project).permit(:name, :description)
  end
end

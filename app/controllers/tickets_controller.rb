class TicketsController < ApplicationController
  before_action :set_project, only: [:new, :show, :create, :update, :destroy, :edit]
  before_action :require_signin!, except: [:index, :show]

  def new
    @project = Project.find(params[:project_id])  
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user

    if @ticket.save
      redirect_to [@project, @ticket], notice: "Ticket has been created."
    else
      flash[:danger] = "Ticket has not been created."
      render :new
    end
  end

  def show
    @ticket = @project.tickets.find(params[:id]) 
  end

  def edit
    @ticket = @project.tickets.find(params[:id])
  end

  def update
    @ticket = @project.tickets.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to [@project, @ticket], notice: "Ticket has been updated." 
    else
      flash[:danger] = "Ticket has not been updated."
      render :edit
    end
  end

  def destroy
    @ticket = @project.tickets.find(params[:id])
    @ticket.destroy
    redirect_to @project, notice: "Ticket has been deleted." 
  end
  private
  def ticket_params
    params.require(:ticket).permit(:title, :description) 
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end

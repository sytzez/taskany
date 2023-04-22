# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = @project.tasks
  end

  def show
    redirect_to project_tasks_url(@project)
  end

  def new
    @task = @project.tasks.build
  end

  def edit; end

  def create
    @task = @project.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_task_url(@project, @task), notice: t('.successfully.created') }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_task_url(@project, @task), notice: t('.successfully.updated') }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_tasks_url(@project), notice: t('.successfully.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:assigned_user_id, :title, :description, :story_points, :status)
  end
end

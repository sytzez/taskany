require 'rails_helper'

RSpec.describe "projects/:id/tasks", type: :request do

  let(:project) { create :project_with_tasks }

  let(:user) { create :user }

  let(:valid_attributes) do
    {
      assigned_user_id: user.id,
      title: 'A title',
      description: 'A description',
      story_points: 1,
    }
  end

  let(:invalid_attributes) do
    {
      assigned_user_id: 0,
      title: '',
      description: '',
      story_points: 0,
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      get project_tasks_url(project)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get project_task_url(project, project.tasks.first)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_project_task_url(project)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_project_task_url(project, project.tasks.first)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post project_tasks_url(project), params: { task: valid_attributes }
        }.to change(project.tasks, :count).by(1)
      end

      it "redirects to the created task" do
        post project_tasks_url(project), params: { task: valid_attributes }
        expect(response).to redirect_to(project_task_url(project, project.tasks.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post project_tasks_url(project), params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end
    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post project_tasks_url(project), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested task" do
        task = project.tasks.first
        patch project_task_url(project, task), params: { task: valid_attributes }
        task.reload
        expect(tasks.title).to eq valid_attributes[:title]
        expect(tasks.description).to eq valid_attributes[:description]
        expect(tasks.story_points).to eq valid_attributes[:story_points]
      end

      it "redirects to the task" do
        task = project.tasks.first
        patch project_task_url(project, task), params: { task: valid_attributes }
        task.reload
        expect(response).to redirect_to(project_task_url(project, task))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        task = project.tasks.first
        patch project_task_url(project, task), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      expect {
        delete project_task_url(project, project.tasks.first)
      }.to change(project.tasks, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete project_task_url(project, project.tasks.first)
      expect(response).to redirect_to(project_tasks_url(project))
    end
  end
end

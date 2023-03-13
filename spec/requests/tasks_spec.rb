require 'rails_helper'

RSpec.describe "projects/:id/tasks", type: :request do

  let(:user) { create :user }

  let!(:project) { create :project_with_tasks }

  let(:task) { project.tasks.first }

  let(:valid_attributes) do
    {
      assigned_user_id: user.id,
      title: 'A title',
      description: 'A description',
      story_points: 1,
      status: 'on_hold',
    }
  end

  let(:invalid_attributes) do
    {
      assigned_user_id: 0,
      title: '',
      description: '',
      story_points: 0,
      status: '',
    }
  end

  context "when signed in" do
    before { sign_in user }

    describe "GET /index" do
      it "renders a successful response" do
        get project_tasks_url(project)
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renderects to the project tasks page" do
        get project_task_url(project, task)
        expect(response).to redirect_to(project_tasks_url(project))
      end
    end

    context "when the task is not in the project", :realistic_error_responses do
      let(:task) { create :task }

      describe "GET /show" do
        it "renders a response with 404 status" do
          get project_task_url(project, task)
          expect(response).to have_http_status(:not_found)
        end
      end

      describe "GET /edit" do
        it "renders a response with 404 status" do
          get edit_project_task_url(project, task)
          expect(response).to have_http_status(:not_found)
        end
      end

      describe "PATCH /update" do
        it "renders a response with 404 status" do
          patch project_task_url(project, task), params: { task: valid_attributes }
          expect(response).to have_http_status(:not_found)
        end
      end

      describe "DELETE /destroy" do
        it "renders a response with 404 status" do
          delete project_task_url(project, task)
          expect(response).to have_http_status(:not_found)
        end
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
        get edit_project_task_url(project, task)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Task" do
          expect {
            post project_tasks_url(project), params: { task: valid_attributes }
          }.to change(Task, :count).by(1)
        end

        it "redirects to the created task" do
          post project_tasks_url(project), params: { task: valid_attributes }
          project.reload
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
          patch project_task_url(project, task), params: { task: valid_attributes }
          task.reload
          expect(task.title).to eq valid_attributes[:title]
          expect(task.description).to eq valid_attributes[:description]
          expect(task.story_points).to eq valid_attributes[:story_points]
          expect(task.status).to eq valid_attributes[:status]
        end

        it "redirects to the task" do
          patch project_task_url(project, task), params: { task: valid_attributes }
          task.reload
          expect(response).to redirect_to(project_task_url(project, task))
        end
      end

      context "with invalid parameters" do

        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          patch project_task_url(project, task), params: { task: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end

      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested task" do
        expect {
          delete project_task_url(project, task)
        }.to change(project.tasks, :count).by(-1)
      end

      it "redirects to the tasks list" do
        delete project_task_url(project, task)
        expect(response).to redirect_to(project_tasks_url(project))
      end
    end
  end

  context "when not signed in" do
    describe "GET /index" do
      it "redirects to the sign in page" do
        get project_tasks_url(project)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /show" do
      it "redirects to the sign in page" do
        get project_task_url(project, task)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /new" do
      it "redirects to the sign in page" do
        get new_project_task_url(project)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /edit" do
      it "redirects to the sign in page" do
        get edit_project_task_url(project, task)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST /create" do
      it "redirects to the sign in page" do
        post project_tasks_url(project), params: { task: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PATCH /update" do
      it "redirects to the sign in page" do
        patch project_task_url(project, task), params: { task: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE /destroy" do
      it "redirects to the sign in page" do
        delete project_task_url(project, task)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

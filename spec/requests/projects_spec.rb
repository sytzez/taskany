# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/projects' do
  let!(:project) { create(:project) }

  let(:valid_attributes) do
    {
      title: 'A title'
    }
  end

  let(:invalid_attributes) do
    {
      title: ''
    }
  end

  context 'when signed in' do
    let(:user) { create(:user) }

    before { sign_in user }

    describe 'GET /index' do
      it 'redirects to the tasks index' do
        get projects_url
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get project_url(project)
        expect(response).to redirect_to project_tasks_url(project)
      end
    end

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_project_url
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'renders a successful response' do
        get edit_project_url(project)
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Project' do
          expect do
            post projects_url, params: { project: valid_attributes }
          end.to change(Project, :count).by(1)
        end

        it 'redirects to the created project' do
          post projects_url, params: { project: valid_attributes }
          expect(response).to redirect_to(project_url(Project.last))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Project' do
          expect do
            post projects_url, params: { project: invalid_attributes }
          end.not_to change(Project, :count)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post projects_url, params: { project: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        it 'updates the requested project' do
          patch project_url(project), params: { project: valid_attributes }
          project.reload
          expect(project.title).to eq valid_attributes[:title]
        end

        it 'redirects to the project' do
          patch project_url(project), params: { project: valid_attributes }
          project.reload
          expect(response).to redirect_to(project_url(project))
        end
      end

      context 'with invalid parameters' do
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          patch project_url(project), params: { project: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested project' do
        expect do
          delete project_url(project)
        end.to change(Project, :count).by(-1)
      end

      it 'redirects to the projects list' do
        delete project_url(project)
        expect(response).to redirect_to(projects_url)
      end
    end
  end

  context 'when not signed in' do
    describe 'GET /index' do
      it 'redirects to the sign in page' do
        get projects_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET /show' do
      it 'redirects to the sign in page' do
        get project_url(project)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET /new' do
      it 'redirects to the sign in page' do
        get new_project_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET /edit' do
      it 'redirects to the sign in page' do
        get edit_project_url(project)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST /create' do
      it 'redirects to the sign in page' do
        post projects_url, params: { task: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH /update' do
      it 'redirects to the sign in page' do
        patch project_url(project), params: { task: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE /destroy' do
      it 'redirects to the sign in page' do
        delete project_url(project)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

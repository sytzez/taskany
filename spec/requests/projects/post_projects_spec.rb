# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /projects' do
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
    before { sign_in create :user }

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

      it 'renders a response with 422 status' do
        post projects_url, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'when not signed in' do
    describe 'POST /create' do
      it 'redirects to the sign in page' do
        post projects_url, params: { task: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

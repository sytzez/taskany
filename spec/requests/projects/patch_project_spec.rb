# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH /projects/:id' do
  let(:project) { create(:project) }

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
      before do
        patch project_url(project), params: { project: valid_attributes }
      end

      it 'updates the requested project' do
        expect(project.reload.title).to eq valid_attributes[:title]
      end

      it 'redirects to the project' do
        expect(response).to redirect_to(project_url(project))
      end
    end

    context 'with invalid parameters' do
      it 'renders a response with 422 status' do
        patch project_url(project), params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the project does not exist' do
      it 'returns a not found error' do
        expect do
          patch project_url(-1), params: { project: invalid_attributes }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      patch project_url(project), params: { task: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

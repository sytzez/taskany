# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /projects' do
  context 'when signed in' do
    before { sign_in create :user }

    context 'when there are projects' do
      before { create_list(:project, 3) }

      it 'renders a successful response' do
        get projects_url
        expect(response).to be_successful
      end
    end

    context 'when there are no projects' do
      it 'renders a successful response' do
        get projects_url
        expect(response).to be_successful
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      get projects_url
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

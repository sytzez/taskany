# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /projects/new' do
  context 'when signed in' do
    before { sign_in create :user }

    it 'renders a successful response' do
      get new_project_url
      expect(response).to be_successful
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      get new_project_url
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

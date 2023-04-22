# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/projects/1/tasks').to route_to('tasks#index', project_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/projects/1/tasks/new').to route_to('tasks#new', project_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/projects/1/tasks/2').to route_to('tasks#show', id: '2', project_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/projects/1/tasks/2/edit').to route_to('tasks#edit', id: '2', project_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/projects/1/tasks').to route_to('tasks#create', project_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/projects/1/tasks/2').to route_to('tasks#update', id: '2', project_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/projects/1/tasks/2').to route_to('tasks#update', id: '2', project_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/projects/1/tasks/2').to route_to('tasks#destroy', id: '2', project_id: '1')
    end
  end
end

# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :assigned_user, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :description, null: false
      t.integer :story_points, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end

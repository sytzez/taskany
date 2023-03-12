class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :assigned_user, null: false, foreign_key: { table: :users }
      t.string :title
      t.text :description
      t.integer :story_points

      t.timestamps
    end
  end
end

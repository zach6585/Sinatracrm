class Joins < ActiveRecord::Migration[6.0]
  def change
    create_table :joins do |t| 
      t.integer :worker_id 
      t.integer :project_id
      t.integer :leader
    end 
  end
end

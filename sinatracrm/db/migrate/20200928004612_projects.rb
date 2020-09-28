class Projects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name 
      t.text :notes
    end 
  end
end

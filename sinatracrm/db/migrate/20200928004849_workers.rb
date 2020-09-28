class Workers < ActiveRecord::Migration[6.0]
  def change
    create_table :workers do |t|
      t.string :username 
      t.string :email 
      t.string :password_digest
      t.string :name 
      t.integer :company_id
      t.integer :leader
    end 
  end
end

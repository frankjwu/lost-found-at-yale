class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :netid
    	t.string :fname
    	t.string :lname
    	t.string :email
    	t.string :year
    	t.string :college

      t.timestamps
    end
  end
end

class AddUserIdToFounds < ActiveRecord::Migration
  def change
    add_column :founds, :user_id, :integer
  end
end

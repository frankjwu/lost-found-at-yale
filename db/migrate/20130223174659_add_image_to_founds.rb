class AddImageToFounds < ActiveRecord::Migration
  def change
    add_column :founds, :image, :string
  end
end

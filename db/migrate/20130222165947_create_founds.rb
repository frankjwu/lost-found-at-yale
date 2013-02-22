class CreateFounds < ActiveRecord::Migration
  def change
    create_table :founds do |t|
      t.text :desc
      t.date :date
      t.string :location

      t.timestamps
    end
  end
end

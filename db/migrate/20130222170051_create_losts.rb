class CreateLosts < ActiveRecord::Migration
  def change
    create_table :losts do |t|
      t.text :desc

      t.timestamps
    end
  end
end

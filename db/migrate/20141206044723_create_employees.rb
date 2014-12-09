class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :resume
      t.string :attachment

      t.timestamps
    end
  end
end

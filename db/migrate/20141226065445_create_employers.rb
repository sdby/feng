class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :contact
      t.string :phone

      t.timestamps
    end
  end
end

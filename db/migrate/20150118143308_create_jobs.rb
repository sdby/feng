class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.integer :employer_id

      t.timestamps
    end
    add_index :jobs, [:employer_id, :created_at]
  end
end

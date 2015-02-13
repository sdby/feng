class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :employee_id
      t.integer :job_id

      t.timestamps
    end

    add_index :applications, :employee_id
    add_index :applications, :job_id
    add_index :applications, [:employee_id, :job_id], unique: true
  end
end

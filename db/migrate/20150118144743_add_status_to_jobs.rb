class AddStatusToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :status, :boolean, default:true
  end
end

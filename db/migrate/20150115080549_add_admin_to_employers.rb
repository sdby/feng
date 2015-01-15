class AddAdminToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :admin, :boolean, default:false
  end
end

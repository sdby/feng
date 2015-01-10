class AddRememberTokenToEmployers < ActiveRecord::Migration
  def change
  	add_column :employers, :remember_token, :string
  	add_index :employers, :remember_token
  end
end

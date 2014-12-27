class AddIndexToEmployersEmail < ActiveRecord::Migration
  def change
  	add_index :employers, :email, unique: true
  end
end

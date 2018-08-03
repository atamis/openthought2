class AddUserIdToThoughts < ActiveRecord::Migration[5.2]
  def change
    add_column :thoughts, :user_id, :integer, foreign_key: true
    add_foreign_key :thoughts, :users
  end
end

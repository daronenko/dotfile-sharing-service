class AddUserIdToDotfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :dotfiles, :user_id, :integer
    add_index :dotfiles, :user_id
  end
end

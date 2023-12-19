class CreateDotfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :dotfiles do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :config_type, null: false

      t.timestamps
    end
  end
end

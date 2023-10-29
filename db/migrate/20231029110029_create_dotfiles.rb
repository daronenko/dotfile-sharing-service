class CreateDotfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :dotfiles do |t|
      t.string :title
      t.text :description
      t.string :config_type

      t.timestamps
    end
  end
end

class AddCachedScopedBookmarkVotesToDotfiles < ActiveRecord::Migration[7.1]
  def change
    change_table :dotfiles do |t|
      t.integer :cached_scoped_bookmark_votes_total, default: 0
      t.integer :cached_scoped_bookmark_votes_score, default: 0
      t.integer :cached_scoped_bookmark_votes_up, default: 0
      t.integer :cached_scoped_bookmark_votes_down, default: 0
      t.integer :cached_weighted_bookmark_score, default: 0
      t.integer :cached_weighted_bookmark_total, default: 0
      t.float :cached_weighted_bookmark_average, default: 0.0

      # Dotfile.find_each { |m| m.update_cached_votes("bookmark") }
    end
  end
end

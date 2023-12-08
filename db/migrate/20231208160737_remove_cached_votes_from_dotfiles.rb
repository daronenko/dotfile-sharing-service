class RemoveCachedVotesFromDotfiles < ActiveRecord::Migration[7.1]
 def change
    remove_column :dotfiles, :cached_votes_total
    remove_column :dotfiles, :cached_votes_score
    remove_column :dotfiles, :cached_votes_up
    remove_column :dotfiles, :cached_votes_down
    remove_column :dotfiles, :cached_weighted_score
    remove_column :dotfiles, :cached_weighted_total
    remove_column :dotfiles, :cached_weighted_average
  end 
end

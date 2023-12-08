class Dotfile < ApplicationRecord
  has_one_attached :file
  belongs_to :user
  
  acts_as_votable

  def bookmark!(user)
    if user.voted_up_on? self, vote_scope: "bookmark"
      unvote_by user, vote_scope: "bookmark"
    else
      upvote_by user, vote_scope: "bookmark"
    end
  end

  def upvote!(user)
    if user.voted_up_on? self, vote_scope: "like"
      unvote_by user, vote_scope: "like"
    else
      upvote_by user, vote_scope: "like"
    end
  end

  def downvote!(user)
    if user.voted_down_on? self, vote_scope: "like"
      unvote_by user, vote_scope: "like"
    else
      downvote_by user, vote_scope: "like"
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "description", "config_type", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end

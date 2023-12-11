module DotfilesHelper
  def upvote_label(message, user)
    label_text = if user.voted_up_on? message, vote_scope: "like"
                    "UNvote"
                  else
                    "UPvote"
                  end
    tag.span do
      "#{message.cached_scoped_like_votes_up} #{label_text}"
    end
  end

  def downvote_label(message, user)
    label_text = if user.voted_down_on? message, vote_scope: "like"
                    "UNvote"
                  else
                    "DOWNvote"
                  end
    tag.span do
      "#{message.cached_scoped_like_votes_down} #{label_text}"
    end
  end

  def upvote_label_styles(dotfile, user)
    if user&.voted_up_on? dotfile, vote_scope: "like"
      "background-color: #e9ecef;"
    end
  end

  def downvote_label_styles(dotfile, user)
    if user&.voted_down_on? dotfile, vote_scope: "like"
      "background-color: #e9ecef;"
    end
  end

  def bookmark_label_styles(message, user)
    if user.voted_up_on? message, vote_scope: "bookmark"
      "background-color: #e9ecef;"
    end
  end


  def bookmark_label_styles(dotfile, user)
    if user&.voted_up_on? dotfile, vote_scope: "bookmark"
      "background-color: #e9ecef;"
    end
  end
end

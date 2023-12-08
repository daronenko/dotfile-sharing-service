module DotfilesHelper
  def upvote_label(dotfile, user)
    label_text = if user&.voted_up_on? dotfile, vote_scope: "like"
                    "UNvote"
                  else
                    "UPvote"
                  end
    tag.span do
      label_text
    end
  end

  def downvote_label(dotfile, user)
    label_text = if user&.voted_down_on? dotfile, vote_scope: "like"
                    "UNvote"
                  else
                    "DOWNvote"
                  end
    tag.span do
      label_text
    end
  end

  def upvote_label_styles(dotfile, user)
    if user&.voted_up_on? dotfile, vote_scope: "like"
      "background-color: grey;"
    end
  end

  def downvote_label_styles(dotfile, user)
    if user&.voted_down_on? dotfile, vote_scope: "like"
      "background-color: grey;"
    end
  end

  def bookmark_label(dotfile, user)
    label_text = if user&.voted_up_on? dotfile, vote_scope: "bookmark"
                    "BookmarkED"
                  else
                    "Bookmark"
                  end
    tag.span do
      label_text
    end
  end

  def bookmark_label_styles(dotfile, user)
    if user&.voted_up_on? dotfile, vote_scope: "bookmark"
      "background-color: grey;"
    end
  end
end

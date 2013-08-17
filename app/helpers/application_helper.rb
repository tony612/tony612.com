module ApplicationHelper
  def cache_key_for_posts(posts)
    max_id         = posts.maximum(:id).try(:to_s, :number)
    max_updated_at = posts.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/all-#{max_id}-#{max_updated_at}"
  end
end

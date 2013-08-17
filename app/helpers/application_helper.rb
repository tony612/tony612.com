module ApplicationHelper
  def cache_key_for_posts(posts)
    max_id         = posts.select(:id).max.id
    max_updated_at = posts.select(:updated_at).max.updated_at.try(:to_s, :number)
    "posts/all-#{max_id}-#{max_updated_at}"
  end
end

module ApplicationHelper
  def cache_key_for_posts(posts)
    max_id         = posts.max_by(&:id).id
    max_updated_at = posts.max_by(&:updated_at).updated_at.try(:utc).try(:to_s, :number)
    "posts/all-#{max_id}-#{max_updated_at}"
  end
end

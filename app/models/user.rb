class User
  def self.find_from_user_info(user_info=['', ''])
    return nil unless user_info.is_a?(Array)
    username, email = user_info
    id_str = username + ':' + email
    return user_info if id_str == ENV['GITHUB_ADMIN_ID']
    nil
  end
end

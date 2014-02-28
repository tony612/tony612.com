Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :github
  manager.failure_app = SessionsController
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    record
  end

  def deserialize(keys)
    username, email = keys
    User.find_from_user_info([username, email])
  end
end

Warden::Strategies.add(:github) do
  def valid?
    env['omniauth.auth'] && env['omniauth.auth'].info
  end

  def authenticate!
    env_auth = env['omniauth.auth']
    if u = User.find_from_user_info([env_auth.info.nickname, env_auth.info.email])
      success!(u)
    else
      fail!("Wrong user!")
    end
  end
end

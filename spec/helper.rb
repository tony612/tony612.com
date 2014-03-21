require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage(95)
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'helper/warden'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

OmniAuth.config.test_mode = true

def set_auth_back
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    'provider' => 'github',
    'uid' => '123545',
    'info' => {
      nickname: 'admin',
      email: 'admin@example.com'
    }
  })
end

set_auth_back

def in_fail_auth
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    'provider' => 'github',
    'uid' => '123545',
    'info' => {
      nickname: 'foo',
      email: 'foo@bar.com'
    }
  })
  request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  yield
  set_auth_back
  request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
end

RSpec.configure do |config|
  config.include Warden::Test::ControllerHelpers, type: :controller
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Factory Girl
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    # begin
      # DatabaseCleaner.start
    FactoryGirl.lint
    # ensure
      # DatabaseCleaner.clean
    # end
  end
end

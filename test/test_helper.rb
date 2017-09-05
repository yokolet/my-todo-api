require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'shoulda-matchers'
require 'database_cleaner'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryGirl::Syntax::Methods
  DatabaseCleaner.clean_with(:truncation)
  DatabaseCleaner.strategy = :transaction
end

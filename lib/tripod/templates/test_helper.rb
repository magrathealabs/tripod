ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'

Dir[Rails.root.join('test', 'support', '**', '*.rb')].each { |f| require f }

Capybara.javascript_driver = :poltergeist

module ActiveSupport
  class TestCase
    include FactoryGirl::Syntax::Methods

    self.use_transactional_tests = false

    setup do
      DatabaseRewinder.clean_all
    end

    teardown do
      DatabaseRewinder.clean
    end
  end
end

module ActionDispatch
  class IntegrationTest
    include Devise::Test::IntegrationHelpers
    include Capybara::DSL

    teardown do
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end

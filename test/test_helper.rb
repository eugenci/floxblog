ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end

module TestDryUtils
  def create_sample_user(email = 'user1@gmail.com')
    User.create! email: email,
      password: 'test1234',
      username: 'boo'
  end

  def create_sample_post(user, title = 'title')
    user.posts.create! title: title, content: 'content'
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'email, passowrd and username attriutes are mandatory' do
    user = User.new

    assert user.invalid?, 'Instead, user is perfectly valid!'
    assert_equal 3, user.errors.size, "Instead user has #{user.errors.size} errors: #{user.errors.full_messages}!"
    assert user.errors[:password].present?, "Instead, password is empty!"
    assert user.errors[:email].present?, "Instead email is empty!"
    assert user.errors[:username].present?, "Instead username is empty!"
  end

  test 'both username and email attribute should be unique' do
    user1 = User.new email: 'john1@mail.com', password: 'test1234', username: 'john1'
    user2 = User.new email: 'john1@mail.com', password: 'test1234', username: 'john1'

    user1.save!

    assert_raise ActiveRecord::RecordInvalid do
      user2.save!

      assert_equal 2, user.errors.size, "Instead user has #{user.errors.size} errors: #{user.errors.full_messages}!"
      assert user.errors[:username].present?, 'username attribute must be unique'
      assert user.errors[:email].present?, 'email attribute must be unique'
    end
  end


end

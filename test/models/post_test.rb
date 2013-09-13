require 'test_helper'

class PostTest < ActiveSupport::TestCase

  setup do
    @user = User.create! email: 'john@mail.com',
                         password: 'test1234',
                         username: 'jwizard'
  end

  test 'user, title and content attributes are mandatory' do
    post = Post.new

    assert post.invalid?, 'Instead, post is perfectly valid!'
    assert_equal 3, post.errors.size, "Instead post has #{post.errors.size} errors!"
    assert post.errors[:content].present?, "Instead, content is empty!"
    assert post.errors[:title].present?, "Instead title is empty!"
    assert post.errors[:user].present?, "Instead title is empty!"
  end


  test 'title attribute should be unique' do
    post1 = Post.new title: 'boo', content: 'blah', user: @user
    post2 = Post.new title: 'boo', content: 'blah2', user: @user

    post1.save!

    assert_raise ActiveRecord::RecordInvalid do
      post2.save!
    end
  end

end

require 'test_helper'

class PostFlowsTest < ActionDispatch::IntegrationTest

  include TestDryUtils

  setup do
    @user = create_sample_user
    @post = create_sample_post(@user)
  end

  test "login and create one post" do
    get "/"
    assert_redirected_to new_user_session_path, 'mmm, it should redirect me to user login'

    post user_session_path, user: { email: @user.email, password: 'test1234'}
    assert_redirected_to root_path


    get '/posts'
    assert_response :success

    get '/posts/new'
    assert_response :success

    assert_difference 'Post.count' do
      post 'posts', post: {content: 'blah', title: 'my first title'}
    end

  end
end

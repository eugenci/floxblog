require 'test_helper'

# Positive tests with user signed in
class PostsControllerTest < ActionController::TestCase

  include TestDryUtils

  setup do
    @user  = create_sample_user
    @user2 = create_sample_user('user2@mail.com')
    @post = create_sample_post(@user)

    sign_in @user
  end

  test "should list only posts currently signed in user" do
    sign_out @user
    sign_in @user2
    create_sample_post(@user2, 'title2')
    create_sample_post(@user2, 'title3')
    create_sample_post(@user2, 'title4')
    get :index
    assert_response :success

    posts_of_user2 = assigns(:posts)

    assert_equal 3, posts_of_user2.size, 'Instead should be listed only 3 posts of user2'
    assert_equal 1, posts_of_user2.load.map(&:user_id).uniq.size, 'All posts belongs indeed only to one user'

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { content: 'some content', title: 'title 1' }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: { content: @post.content, title: @post.title }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end

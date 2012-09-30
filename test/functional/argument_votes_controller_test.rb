require 'test_helper'

class ArgumentVotesControllerTest < ActionController::TestCase
  setup do
    @argument_vote = argument_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:argument_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create argument_vote" do
    assert_difference('ArgumentVote.count') do
      post :create, argument_vote: {  }
    end

    assert_redirected_to argument_vote_path(assigns(:argument_vote))
  end

  test "should show argument_vote" do
    get :show, id: @argument_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @argument_vote
    assert_response :success
  end

  test "should update argument_vote" do
    put :update, id: @argument_vote, argument_vote: {  }
    assert_redirected_to argument_vote_path(assigns(:argument_vote))
  end

  test "should destroy argument_vote" do
    assert_difference('ArgumentVote.count', -1) do
      delete :destroy, id: @argument_vote
    end

    assert_redirected_to argument_votes_path
  end
end

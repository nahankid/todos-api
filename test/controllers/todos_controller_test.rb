require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = create(:todo)
    @headers = valid_headers(@todo.creator_id)

    @user = create(:user)
    @invalid_headers = valid_headers(@user.id)
  end

  test "should get index" do
    get todos_url, headers: @headers, as: :json
    assert_response :success
  end

  test "should create todo with valid params" do
    assert_difference('Todo.count') do
      post todos_url, params: { todo: { title: Faker::Lorem.word } }, headers: @headers, as: :json
    end

    assert_response 201
  end

  test "should not create todo with invalid params" do
    assert_no_difference('Todo.count') do
      post todos_url, params: { todo: { title: nil } }, headers: @headers, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show todo" do
    get todo_url(@todo), headers: @headers, as: :json
    assert_response :success
    assert_equal content_type, response.content_type
  end

  test "should not show todo if not owner" do
    get todo_url(@todo), headers: @invalid_headers, as: :json
    assert_response :not_found
  end

  test "should update todo with valid params" do
    patch todo_url(@todo), params: { todo: { title: Faker::Lorem.word } }, headers: @headers, as: :json
    assert_response :no_content
  end

  test "should not update todo with invalid params" do
    patch todo_url(@todo), params: { todo: { title: nil } }, headers: @headers, as: :json
    assert_response :unprocessable_entity
  end

  test "should not update todo if not owner" do
    patch todo_url(@todo), params: { todo: { title: Faker::Lorem.word } }, headers: @invalid_headers, as: :json
    assert_response :not_found
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete todo_url(@todo), headers: @headers, as: :json
    end

    assert_response :no_content
  end

  test "should not destroy todo if not owner" do
    assert_no_difference('Todo.count') do
      delete todo_url(@todo), headers: @invalid_headers, as: :json
    end

    assert_response :not_found
  end
end

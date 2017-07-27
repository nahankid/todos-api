require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = create(:todo)
    @items = create_list(:item, 10, todo: @todo)
    @item = @items.first
    @headers = valid_headers(@todo.creator_id)

    @user = create(:user)
    @elses_headers = valid_headers(@user.id)
  end

  test "should get index" do
    get todo_items_url(@todo), headers: @headers, as: :json
    assert_response :success
  end

  test "should create item with valid params" do
    assert_difference('Item.count') do
      post todo_items_url(@todo), params: { item: { name: Faker::Name.name } }, headers: @headers, as: :json
    end

    assert_response :created
  end

  test "should not create item with invalid params" do
    assert_no_difference('Item.count') do
      post todo_items_url(@todo), params: { item: { name: nil } }, headers: @headers, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show item when it exists" do
    get todo_item_url(@todo, @item), headers: @headers, as: :json
    assert_response :success
  end

  test "should not show item when it doesn't exist" do
    get todo_item_url(@todo, 300), headers: @headers, as: :json
    assert_response :not_found
  end

  test "should not show item if not owner" do
    get todo_item_url(@todo, @item), headers: @elses_headers, as: :json
    assert_response :not_found
  end

  test "should update item with valid params" do
    patch todo_item_url(@todo, @item), params: { item: { name: Faker::Name.name } }, headers: @headers, as: :json
    assert_response :no_content
  end

  test "should not update item with invalid params" do
    patch todo_item_url(@todo, @item), params: { item: { name: nil } }, headers: @headers, as: :json
    assert_response :unprocessable_entity
  end

  test "should not update item if not owner" do
    patch todo_item_url(@todo, @item), params: { item: { name: Faker::Name.name } }, headers: @elses_headers, as: :json
    assert_response :not_found
  end

  test "should not update a non-existant item" do
    patch todo_item_url(@todo, 300), params: { item: { name: nil } }, headers: @headers, as: :json
    assert_response :not_found
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete todo_item_url(@todo, @item), headers: @headers, as: :json
    end

    assert_response :no_content
  end

  test "should not destroy item if not owner" do
    assert_no_difference('Item.count') do
      delete todo_item_url(@todo, @item), headers: @elses_headers, as: :json
    end

    assert_response :not_found
  end
end

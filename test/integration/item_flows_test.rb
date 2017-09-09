require 'test_helper'

class ItemFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @todo = create(:todo)
    @todo_id = @todo["id"]
    @items = create_list(:item, 20, todo_id: @todo_id)
    @item_id = @items.last["id"]
  end

  # GET /todos/:todo_id/items
  test "get /todos/todo_id/items" do
    get "/todos/#{@todo_id}/items"
    assert_response :success

    data = JSON.parse(@response.body)
    assert_equal(20, data.size)
  end

  # GET todos/:id/items with wrong id
  test "get /todos/100/items" do
    wrong_id = 100
    get "/todos/#{wrong_id}/items"
    assert_response 404
    assert_match(/Couldn't find Todo/, @response.body)
  end
end

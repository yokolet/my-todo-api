require 'test_helper'

class ItemFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @todo = create(:todo)
    @todo_id = @todo["id"]
    @items = create_list(:item, 20, todo_id: @todo_id)
    @item_id = @items.last["id"]
  end

  # GET /todos/:todo_id/items
  test "get /todos/:todo_id/items" do
    get "/todos/#{@todo_id}/items"
    assert_response :success

    data = JSON.parse(@response.body)
    assert_equal(20, data.size)
  end

  # GET todos/:todo_id/items with wrong todo_id
  test "get /todos/100/items" do
    wrong_id = 100
    get "/todos/#{wrong_id}/items"
    assert_response :not_found
    assert_match(/Couldn't find Todo/, @response.body)
  end

  # GET /todos/:todo_id/items/:id
  test "get /todos/:todo_id/items/:id" do
    get "/todos/#{@todo_id}/items/#{@item_id}"
    assert_response :success

    data = JSON.parse(@response.body)
    assert_equal(@item_id, data["id"])
  end

  # GET /todos/:todo_id/items/:id with wrong id
  test "get /todos/:todo_id/items/1000" do
    wrong_id = 1000
    get "/todos/#{@todo_id}/items/#{wrong_id}"
    assert_response :not_found
    assert_match(/Couldn't find Item/, @response.body)
  end

  # POST /todos/:todo_id/items
  test "post /todos/:todo_id/items" do
    params = { item: { name: Faker::StarWars.character,
                       done: false }}
    post "/todos/#{@todo_id}/items", params: params
    assert_response :created
  end

  # POST /todos/:todo_id/items with invalid params
  test "post /todos/:todo_id/items, params: invalid" do
    params = { item: { done: true }}
    post "/todos/#{@todo_id}/items", params: params
    assert_response :unprocessable_entity
    assert_match(/Validation failed: Name can't be blank/, @response.body)
  end

  # PUT /todos/:todo_id/items/:id
  test "put /todos/:todo_id/items/:id" do
    params = { item: { name: 'Snow White' }}
    put "/todos/#{@todo_id}/items/#{@item_id}", params: params
    assert_response :no_content

    updated = Item.find(@item_id)
    assert_match(/Snow White/, updated.name)
  end

  # PUT /todos/:todo_id/items/:id with invalid params
  test "put /todos/:todo_id/items/:id, params: invalid" do
    params = { item: { name: '' }}
    put "/todos/#{@todo_id}/items/#{@item_id}", params: params
    assert_response :unprocessable_entity
    assert_match(/Validation failed: Name can't be blank/, @response.body)
  end

  # DELETE /todos/:todo_id/items/:id
  test "delete /todos/:todo_id/items/:id" do
    delete "/todos/#{@todo_id}/items/#{@item_id}"
    assert_response :no_content
  end
end

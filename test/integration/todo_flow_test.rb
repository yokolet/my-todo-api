require 'test_helper'

class TodoFlowTest < ActionDispatch::IntegrationTest
  def setup
    @todos = []
    @items = []
    for i in 0...5
      @todos << create(:todo)
    end
    for i in 0...10
      @items << create(:item)
    end
    @todo_id = @todos.last.id
  end

  # GET /todos
  test "get /todos" do
    get "/todos"
    assert_response :success
    data = JSON.parse(@response.body)
    refute_empty data
  end

  # GET todos/:id
  test "get /todos/:id" do
    get "/todos/#{@todo_id}"
    assert_response :success
    data = JSON.parse(@response.body)
    refute_empty data
    assert_equal(@todo_id, data["id"])
  end

  # GET todos/:id with wrong id
  test "get /todos/100" do
    get "/todos/100"
    assert_response 404
    assert_match(/Couldn't find Todo/, @response.body)
  end
end

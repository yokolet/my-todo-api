require 'test_helper'

class TodoFlowTest < ActionDispatch::IntegrationTest
  def setup
    @todos = create_list(:todo, 5)
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

  # POST /todos
  test "post /todos" do
    params = { todo: { title: Faker::Hacker.verb.capitalize,
                        created_by: Faker::Number.number(11)}}
    post "/todos", params: params
    assert_response 201
    data = JSON.parse(@response.body)
    assert_equal(params[:todo][:title], data["title"])
  end

  # POST /todos with wrong params
  test "post /todos/{title: 'title only'}" do
    params = { todo: { title: Faker::Hacker.verb.capitalize }}
    post "/todos", params: params
    assert_response 422
    data = JSON.parse(@response.body)
    assert_match(/Validation failed: Created by can't be blank/, @response.body)
  end

  # PUT /todos/:id
  test "put /todos/:id" do
    params = { todo: { title: Faker::Hacker.verb.capitalize }}
    put "/todos/#{@todo_id}", params: params
    assert_response 204
    assert_empty @response.body
  end

  # DELETE /todos/:id
  test "delete /todos/:id" do
    delete "/todos/#{@todo_id}"
    assert_response 204
  end
end

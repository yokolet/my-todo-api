class TodosController < ApplicationController
  # GET /todos
  def index
    @todos = Todo.all
    render json: @todos
  end

  # GET /todos/:id
  def show
    todo_id = params[:id]
    @todo = Todo.find(params[:id])
    render json: @todo, status: :ok
  end

  # POST /todos
  def create
    puts "create: #{params}"
    @todo = Todo.new(todo_params)
    @todo.save
    render json: @todo, status: :created
  end

  private
  def todo_params
    params.require(:todo).permit(:title, :created_by)
  end
end

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
    @todo = Todo.create!(todo_params)
    render json: @todo, status: :created
  end

  # PUT /todos/:id
  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    head :no_content
  end

  private
  def todo_params
    params.require(:todo).permit(:title, :created_by)
  end
end

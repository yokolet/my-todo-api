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
end

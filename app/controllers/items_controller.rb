class ItemsController < ApplicationController
  # GET /todos/:id/items
  def index
    @todo = Todo.find(params[:todo_id])
    @items = @todo.items if @todo
    render json: @items, status: :ok
  end
  
end

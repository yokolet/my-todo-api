class ItemsController < ApplicationController
  # GET /todos/:id/items
  def index
    @todo = Todo.find(params[:todo_id])
    @items = @todo.items if @todo
    render json: @items, status: :ok
  end

  def show
    @todo = Todo.find(params[:todo_id])
    @item = @todo.items.find_by!(id: params[:id]) if @todo
    render json: @item, status: :ok
  end
  
end

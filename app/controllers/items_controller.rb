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

  def create
    @todo = Todo.find(params[:todo_id])
    @item = @todo.items.create!(item_params)
    render json: @item, status: :created
  end

  def update
    @todo = Todo.find(params[:todo_id])
    @item = @todo.items.find_by!(id: params[:id]) if @todo
    @item.update!(item_params)
    head :no_content
  end

  private
  def item_params
    params.require(:item).permit(:name, :done)
  end
end

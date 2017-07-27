class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    @items = @todo.items
    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = @todo.items.create!(item_params)
    render json: @item, status: :created
  end

  # PATCH/PUT /items/1
  def update
    @item.update!(item_params)
    head :no_content
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    head :no_content
  end

  private
    def set_todo
      @todo = current_user.todos.find(params[:todo_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = @todo.items.find(params[:id]) if @todo
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :done)
    end
end

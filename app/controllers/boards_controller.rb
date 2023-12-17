# applicationControllerを継承する必要がある。
class BoardsController < ApplicationController
  before_action :set_board, only: [:edit, :update, :destroy, :toggle]
  # 以下のメソッドをアクションともいう。
  def index
    @boards = Board.all
  end
  
  def new
    @board = Board.new
  end
=begin
 createメソッドは新規登録ボタンが押されたときに呼ばれる
 redirect_to は、どのURLに遷移するかしていする指定する
=end
  def create
   
    @board = Board.new(board_params)
    if @board.save
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  def edit
    # p params[:id]
    # @board = Board.find(params[:id])
  end
  
  def update
    # @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to root_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def destroy
    # @board = Board.find(params[:id])
    @board.destroy
    redirect_to root_path, status: :see_other
  end

  # def show
  #   redirect_to root_path, status: :see_other
  # end
  
  def toggle
    # @board = Board.find(params[:id])
    # @board.update(completed: !@board.completed)
    render turbo_stream: turbo_stream.replace(
      @board,
      partial: 'completed',
      locals: { board: @board}
      )
  end
 
  private
  def board_params
    params.require(:board).permit(:title,:title2)
  end
  
  def set_board
    @board = Board.find(params[:id])
  end
  
end
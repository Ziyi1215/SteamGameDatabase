class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :find_information, only: [:show, :new, :edit, :create, :update]
  before_action :find_relationship, only: [:show, :edit, :update]

  # GET /games
  def index
    @games = Game.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /games/#id
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/#id/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    if @game.save
      Develop.create game_id: @game.id, developer_id: params[:developer_id]
      Publish.create game_id: @game.id, publisher_id: params[:publisher_id]
      Support.create_record(@game.id, params[:languages])
      flash[:success] = "Create success!"
      redirect_to @game
    else
      render '/games/new'
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      develop = Develop.find_by(game_id: @game.id)
      if develop != nil
        develop.developer_id = params[:developer_id]
      else
        Develop.create game_id: @game.id, developer_id: params[:developer_id]
      end
      publish = Publish.find_by(game_id: @game.id)
      if publish != nil
        publish.publisher_id = params[:publisher_id]
      else
        Publish.create game_id: @game.id, publisher_id: params[:publisher_id]
      end
      Support.delete_record(params[:id])
      Support.create_record(params[:id], params[:languages])
      flash[:success] = "Update success!"
      redirect_to @game
    else
      render 'edit'
    end
  end

  # DELETE /games/1
  def destroy
    develop = Develop.where(game_id: params[:id])
    if develop != nil
      develop.destroy_all
    end
    publish = Publish.where(game_id: params[:id])
    if publish != nil
      publish.destroy_all
    end
    Support.delete_record(params[:id])
    @game.destroy
    flash[:success] = "Delete success"
    redirect_to games_path
  end

  private
    def game_params
      params.require(:game).permit(:name, :price)
    end

    def set_game
      if Game.where(id: params[:id]).blank?
        redirect_to games_path
      else
        @game = Game.find(params[:id])
      end
    end

    def find_relationship
      develop = Develop.find_by(game_id: params[:id])
      if develop != nil
        @game_developer = Developer.find(develop.developer_id)
      end
      publish = Publish.find_by(game_id: params[:id])
      if publish != nil
        @game_publisher = Publisher.find(publish.publisher_id)
      end
      @game_languages = Array.new
      Support.where(game_id: params[:id]).each do |support|
        @game_languages << Language.find(support.language_id)
      end
    end

    def find_information
      @developers = Developer.order(:name)
      @publishers = Publisher.order(:name)
      @packages = Package.order(:name)
      @languages = Language.order(:name)
    end

end

class PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy]
  before_action :find_relationship, only: [:show, :edit, :update]

  # GET /developers
  def index
    @publishers = Publisher.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /developers/#id
  def show
  end

  # GET /developers/new
  def new
    @publisher = Publisher.new
  end

  # GET /developers/#id/edit
  def edit
  end

  # POST /developers
  def create
    @publisher = Publisher.new(publisher_params)

    if @publisher.save
      flash[:success] = "Create success!"
      redirect_to @publisher
    else
      render 'new'
    end
  end

  # PATCH/PUT /developers/1
  def update
    if @publisher.update(publisher_params)
      flash[:success] = "Update success!"
      redirect_to @publisher
    else
      render 'edit'
    end
  end

  # DELETE /developers/1
  def destroy
    @publisher.destroy
    flash[:success] = "Delete success"
    redirect_to home_path
  end

  private
    def publisher_params
      params.require(:publisher).permit(:name)
    end

    def set_publisher
      if Publisher.where(id: params[:id]).blank?
        redirect_to developers_path
      else
        @publisher = Publisher.find(params[:id])
      end
    end

    def find_relationship
      @published_games = Array.new
      publishes = Publish.where(publisher_id: params[:id])
      if publishes != nil
        publishes.each do |publish|
          @published_games << Game.find(publish.game_id)
        end
      end
    end
end

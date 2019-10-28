class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :edit, :update, :destroy]
  before_action :find_relationship, only: [:show, :edit, :update]

  # GET /developers
  def index
    @developers = Developer.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /developers/#id
  def show
  end

  # GET /developers/new
  def new
    @developer = Developer.new
  end

  # GET /developers/#id/edit
  def edit
  end

  # POST /developers
  def create
    @developer = Developer.new(developer_params)

    if @developer.save
      flash[:success] = "Create success!"
      redirect_to @developer
    else
      render 'new'
    end
  end

  # PATCH/PUT /developers/1
  def update
    if @developer.update(developer_params)
      flash[:success] = "Update success!"
      redirect_to @developer
    else
      render 'edit'
    end
  end

  # DELETE /developers/1
  def destroy
    Develop.delete_record(@developer.id)
    @developer.destroy
    flash[:success] = "Delete success"
    redirect_to developers_path
  end

  private
  def developer_params
    params.require(:developer).permit(:name)
  end

  def set_developer
    if Developer.where(id: params[:id]).blank?
      redirect_to developers_path
    else
      @developer = Developer.find(params[:id])
    end
  end

  def find_relationship
    @developed_games = Array.new
    develops = Develop.where(developer_id: params[:id])
    if develops != nil
      develops.each do |develop|
        @developed_games << Game.find(develop.game_id)
      end
    end
  end

end

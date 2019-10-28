class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  before_action :find_information, only: [:show, :new, :edit, :create, :update]
  before_action :find_relationship, only: [:show, :edit, :update]

  # GET /packages
  def index
    @packages = Package.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /packages/#id
  def show
  end

  # GET /packages/new
  def new
    @package = Package.new
  end

  # GET /packages/#id/edit
  def edit
  end

  # POST /packages
  def create
    @package = Package.new(package_params)
    if @package.save
      Include.create_record(params[:games], @package.id)
      flash[:success] = "Create success!"
      redirect_to @package
    else
      render '/packages/new'
    end
  end

  # PATCH/PUT /packages/1
  def update
    if @package.update(package_params)
      Include.delete_record(@package.id)
      Include.create_record(params[:games], @package.id)
      flash[:success] = "Update success!"
      redirect_to @package
    else
      render 'edit'
    end
  end

  # DELETE /packages/1
  def destroy
    Include.delete_record(@package.id)
    @package.destroy
    flash[:success] = "Delete success"
    redirect_to packages_path
  end

  private
  def package_params
    params.require(:package).permit(:name, :price)
  end

  def set_package
    if Package.where(id: params[:id]).blank?
      redirect_to packages_path
    else
      @package = Package.find(params[:id])
    end
  end

  def find_relationship
    @package_games = Array.new
    Include.where(package_id: params[:id]).each do |include|
      @package_games << Game.find(include.game_id)
    end
  end

  def find_information
    @games = Game.order(:name)
  end
end

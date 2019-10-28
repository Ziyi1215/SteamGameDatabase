class LanguageController < ApplicationController
  before_action :set_language, only: [:show, :edit, :update, :destroy]

  # GET /language
  def index
    @languages = Language.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /language/#id
  def show
  end

  # GET /language/new
  def new
    @language = Language.new
  end

  # GET /language/#id/edit
  def edit
  end

  # POST /language
  def create
    @language = Language.new(language_params)

    if @language.save
      flash[:success] = "Create success!"
      redirect_to @language
    else
      render 'new'
    end
  end

  # PATCH/PUT /language/1
  def update
    if @language.update(language_params)
      flash[:success] = "Update success!"
      redirect_to @language
    else
      render 'edit'
    end
  end

  # DELETE /language/1
  def destroy
    @language.destroy
    flash[:success] = "Delete success"
    redirect_to languages_path
  end

  private
  def language_params
    params.require(:language).permit(:name)
  end

  def set_language
    if Language.where(id: params[:id]).blank?
      redirect_to languages_path
    else
      @language = Language.find(params[:id])
    end
  end
end

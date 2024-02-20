class StylesController < ApplicationController
  before_action :ensure_admin_rights, only: [:destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]

  def index
    @styles = Style.all
  end

  def show
    @style = Style.find(params[:id])
    @beers = Beer.where style_id: @style.id
  end

  def new
    @style = Style.new
  end

  def create
    @style = Style.new params.require(:style).permit(:name, :description)

    if current_user && @style.save
      redirect_to @style, notice: 'Style was successfully created.'
    else
      # @styles = Style.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @style = Style.find(params[:id])

    if current_user && @style.update(params.require(:style).permit(:name, :description))
      redirect_to @style, notice: 'Style was successfully updated.'
    else
      # @styles = Style.all
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @style = Style.find(params[:id])
  end

  def destroy
    style = Style.find params[:id]
    style.delete if current_user
    redirect_to styles_path, notice: 'Style was successfully deleted.'
  end
end

class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_section, only: [:edit, :update, :show, :destroy]

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    @section.user = current_user
    if @section.save
      redirect_to section_path(@section)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @section.update(section_params)
      redirect_to section_path(@section)
    else
      render :edit
    end
  end

  def index
    @sections = current_user.sections.all 
  end

  def show
  end

  def destroy
    if @section.videos.count <1
      @section.destroy
      redirect_to sections_path
    else
      flash[:error] = "There are still videos in this section, so it cant be deleted"
    end
  end

  private

  def section_params
    params.require(:section).permit(:name)
  end

  def set_section
    @section = current_user.sections.find(params[:id])
  end


end

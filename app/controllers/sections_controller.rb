class SectionsController < ApplicationController
  before_action :authenticate_user! #devise helper, enures users are sgned in before actions can be accessed
  before_action :set_user 
  before_action :set_section, only: [:edit, :update, :destroy, :show] 

  def index
    @sections = Section.all
    authorize @sections
  end

  def show
    @videos = policy_scope(Video).where(section_id: @section.id)
    authorize @section
  end  

  def new
    @section = Section.new
    authorize @section
  end

  def create
    @section = Section.new(section_params)
    authorize @section
    if @section.save
      redirect_to section_path(@section)
    else
      render :new
    end
  end

  def edit
    authorize @section
    render :edit
  end

  def update
    authorize @section
    if @section.update(section_params)
      redirect_to section_path(@section)
    else
      render :edit
    end
  end

  def destroy
    authorize @section 
    if @section.videos.count <1
      @section.destroy
      redirect_to sections_path
    else
      flash[:error] = "There are still videos in this section, so it cant be deleted"
      render :show
    end
  end

  private

  def section_params
    params.require(:section).permit(:name)
  end

  def set_section
    @section = Section.find(params[:id])
  end

  def set_user
    @user = current_user
  end

end

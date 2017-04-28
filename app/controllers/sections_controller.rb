class SectionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]#devise helper, enures users are signed in before actions can be accessed
  before_action :set_user, only: [:show] 
  before_action :set_section, only: [:edit, :update, :destroy, :show]

  def index
    @sections = Section.all
    authorize @sections
    respond_to do |format|
      format.html {}
      format.json { render json: @sections}
    end
  end

  def show
    #all sections show for all users, by section policy
    #videos are scoped by user role, by video policy
    #need to set user to determine the checkmarks for videos_watched?(user, video) method
    @videos = policy_scope(Video).where(section_id: @section.id)
    authorize @section
    respond_to do |format|
      format.html {}
      format.json { render json: @videos}
    end
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
    #section can only be deleted by admin, and when its empty of videos.
    authorize @section 
    if @section.videos.count <1
      @section.destroy
      redirect_to sections_path
    else
      flash[:error] = "There are still videos in this section, so it can't be deleted"
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

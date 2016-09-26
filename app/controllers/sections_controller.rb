class SectionsController < ApplicationController
#make a before action to ensure user is logged in as well
  def new
    @section = Section.new
  end

  def create
    #raise "create action".inspect
    @section = Section.new(section_params)
    #assign user that created it? or do it via nested resources?
    if @section.save
      redirect_to section_path(@section)
    else
      render :new
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])

    if @section.update(section_params)
      redirect_to section_path(@section)
    else
      render :edit
    end
  end

  def index
    @sections = Section.all 
  end

  def show
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])

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


end

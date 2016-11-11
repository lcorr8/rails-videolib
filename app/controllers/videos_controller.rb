class VideosController < ApplicationController
  before_action :set_user, only: [:index, :create, :edit, :update, :destroy, :watched, :study_suggestions] # , :show

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    # Creating a video with a section by ID
    if !params[:video][:section_id].blank?
      # lets delete the section key from the params hash, which is used to create section by name
      params[:video].delete(:section)
    else
      # Creating a video with a section by name, using section key in params hash
      @section = Section.find_or_create_by(name: params[:video][:section][:name])
      #@section.user = @user
      @section.save
    end

    @video = Video.new(video_params)
    #@video.user = @user

    if @video.save
      redirect_to video_path(@video)
    else
      render :new
    end
  end

  def edit
    #if user is an admin rather than if a video blongs to a user
    if @video = @user.videos.find(params[:id])
      render :edit
    else
      flash[:error] = "Not your video to edit!"
      redirect_to sections_path
    end
  end

  def update
    #account for when a section is being created and a section id is selected
      #update video section by ID
      if !params[:video][:section_id].blank?
        #delete the section name key from the params object
        params[:video].delete(:section)
      else
        #update video section by creating a new section by NAME
        @section = Section.find_or_create_by(name: params[:video][:section][:name])
        #@section.user = @user
        @section.save
      end
    #if you are an admin not if the video belongs to you
    if @video = @user.videos.find(params[:id])
      if @video.update(video_params)
        redirect_to video_path(@video)
      else
        render :edit
      end
    else
      flash[:error] = "Not your video to edit!"
      redirect_to sections_path
    end
  end

  def destroy 
    #if user is admin
    if @video = @user.videos.find(params[:id])
      @video.destroy
      redirect_to videos_path
    else
      flash[:error] = "Not your video to delete!"
      redirect_to sections_path
    end
  end

  

  private

  def video_params
    params.require(:video).permit(:name, :link, :year, :section_id, section: [:name]) # , :watched, :embed_link, :note_ids, :user_id
  end

  def set_user
    @user = current_user
  end

end

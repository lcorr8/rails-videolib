class VideosController < ApplicationController
  before_action :set_user, only: [:index, :show, :create, :edit, :update, :destroy, :watched]


  def index
    #scope to the user's section
    @videos = @user.videos.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    #raise params.inspect
    #if video section_id is not empty then ignore the creation box

    # Creating a video with a section by ID
    if !params[:video][:section_id].blank?
      # lets delete the key from the hash
      params[:video].delete(:section)
      # => raise "stop".inspect
    else
      # Creating a video with a section by name
      @section = Section.find_or_create_by(name: params[:video][:section][:name])
      @section.user = @user
      @section.save
    end

    @video = Video.new(video_params)
    @video.user = @user

    if @video.save
      redirect_to video_path(@video)
    else
      render :new
    end
  end

  def edit
    if @video = @user.videos.find(params[:id])
      render :edit
    else
      flash[:error] = "Not your video to edit!"
      redirect_to sections_path
    end
  end

  def update
    #raise params.inspect
    if @video = @user.videos.find(params[:id])
      if @video.update(video_params)
         if params[:video][:section][:name] != "" 
            @section = Section.find_by(name: params[:video][:section][:name])
            @section.user = @user
            @section.save
          end
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
    #ensure user can delete this video
    if @video = @user.videos.find(params[:id])
      @video.destroy
      redirect_to videos_path
    else
      flash[:error] = "Not your video to delete!"
      redirect_to sections_path
    end
  end

  def watched
    if @video = @user.videos.find(params[:id])
      @video.watched = "yes"
      @video.save
      redirect_to video_path(@video)
    else
      flash[:error] = "Not your video to edit!"
      redirect_to sections_path
    end
  end

  private

  def video_params
    params.require(:video).permit(:name, :link, :year, :watched, :embed_link, :section_id, :note_ids, :user_id, section: [:name])
  end

  def set_user
    @user = current_user
  end

end

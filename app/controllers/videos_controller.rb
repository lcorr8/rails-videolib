class VideosController < ApplicationController
  before_action :authenticate_user! #devise helper, enures users are signed in before actions can be accessed
  before_action :set_user, only: [:index, :create, :edit, :update, :destroy, :watched, :study_suggestions, :show, :api_show] 

  def all_hardest_videos
   # @hardest_videos = Video.hardest_videos
  end


  def show
    @video = Video.find(params[:id])
    authorize @video
    #personal ratings of the video
    @user_ratings = @video.user_ratings(@user)
    #average video ratings if more than one rating present for the video
    if @video.video_ratings.any?
      #calculates the average star rating
      @average_rating = @video.video_ratings.average(:rating_id).to_i.to_s
      @total_video_rating = Rating.find_by(stars: @average_rating)
    end
  end

  def api_show
    @video = Video.find(params[:id])
    render json: @video
  end

  def new
    @video = Video.new
    authorize @video
    #pull section from params to use in req for nested form with custom attr writer
    if params[:section_id]
      @section = params[:section_id]
    end
  end

  def create
    # Creating a video with a section by ID (from select box)
    if !params[:video][:section_id].blank?
      # delete the section key from the params hash, which is used to create section by name
      params[:video].delete(:section)
    else
      # Creating a video with a section by name, using section key in params hash (from write your own new section)
      @section = Section.find_or_create_by(name: params[:video][:section][:name])
      @section.save
    end

    @video = Video.new(video_params)
    authorize @video
    if @video.save
      redirect_to video_path(@video)
    else
      render :new
    end
  end

  def edit
    @video = Video.find(params[:id])
    authorize @video
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
        @section.save
      end

    @video = Video.find(params[:id])
    authorize @video 
      if @video.update(video_params)
        redirect_to video_path(@video)
      else
        render :edit
      end
  end

  def destroy 
    @video = Video.find(params[:id])
    @section = @video.section
    authorize @video 
    @video.destroy
    redirect_to section_path(@section)
  end

  private

  def video_params
    params.require(:video).permit(:name, :link, :year, :flatiron, :section_id, section: [:name])
  end

  def set_user
    @user = current_user
  end

end

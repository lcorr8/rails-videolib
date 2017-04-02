class NotesController < ApplicationController
  before_action :set_user, only: [:index, :show, :create, :edit, :update]
  before_action :set_video, only: [:show, :index, :new, :create, :edit, :update]

  def show
    @note = Note.find(params[:id])
  end

  def index
    #scope index by video and user
    @notes = @video.notes.where(user_id: @user.id)
  end

  def new
    @note = @video.notes.build
  end

  def create
    @note = @video.notes.build(note_params)
    @note.user = @user
    if @note.save
      redirect_to video_note_path(@video, @note)
    else
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
    if @note.user != @user 
      flash[:error] = "Not your note to edit"
    elsif @note.video != @video
      flash[:error] = "Note does not belong to this video"
    end
  end

  def update
    #
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to video_note_path(@video, @note)
    else
      render :edit
    end
  end

  def destroy
  end


  private

  def note_params
    params.require(:note).permit(:content)
  end

  def set_user
    @user = current_user
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end

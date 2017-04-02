class NotesController < ApplicationController
  before_action :set_user, only: [:index, :show, :create, :edit, :update, :destroy]
  before_action :set_video
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def show
    if @note.user == @user
      render :show
    else
      flash[:error] = "Not your note to read"
      render :index
    end
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
    if @note.user != @user 
      flash[:error] = "Not your note to edit"
    elsif @note.video != @video
      flash[:error] = "Note does not belong to this video"
    end
  end

  def update
    if @note.update(note_params)
      redirect_to video_notes_path(@video)
    else
      render :edit
    end
  end

  def destroy
    if @note.user != @user
      flash[:error] = "Not your note to delete"
    elsif @note.video != @video
      flash[:error] = "Note does not belong to this video"
    end
    @note.delete
      redirect_to video_notes_path(@video)
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

  def set_note
    @note = Note.find(params[:id])
  end
end

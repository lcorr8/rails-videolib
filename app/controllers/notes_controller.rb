class NotesController < ApplicationController
  before_action :set_user, only: [:index, :show, :create]
  before_action :set_video, only: [:show, :index, :new, :create]

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
  end

  def update
    @note = Note.update(note_params)
  end

  def destroy
  end


  private

  def note_params
    params.require(:note).permit(:video_id, :content)
  end

  def set_user
    @user = current_user
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end

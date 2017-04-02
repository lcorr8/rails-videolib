class NotesController < ApplicationController
  before_action :set_user, only: [:index]

  def show
    @note = Note.find(params[:id])
  end

  def index
    #scope index by video and user
    @video = Video.find(params[:video_id])
    @notes = @video.notes.where(user_id: @user.id)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    @note = Note.update(note_params)
  end

  def destroy
    @note = Note.find(params[:id])
  end


  private

  def note_params
    params.require(:note).permit(:user_id, :video_id, :content)
  end

  def set_user
    @user = current_user
  end
end

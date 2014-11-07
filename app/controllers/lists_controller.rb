class ListsController < ApplicationController
  def show
    @list = List.find_by_uuid!(params[:id])
    @questions = @list.questions
  end

  def new
    @list = List.new
  end

  def clone
    list_to_copy = List.find_by_uuid!(params[:id])
    @list = List.new_from_existing(list_to_copy)
    render :new
  end

  def create
    @list = List.new list_params
    if @list.save_from_params
      redirect_to list_url(@list.uuid), notice: "List successfully created. Share it using this page url ->    <strong>#{list_url(@list.uuid)}</strong>"
    else
      render :new
    end
  end

  def preview
    @questions = List.split_into_questions(params[:raw_text])
    render "preview", layout: false
  end

  def notify
    @list = List.find_by_uuid!(params[:id])
    NotificationMailer.list_answered(@list).deliver
  end

  private

  def list_params
    params.require(:list).permit(:raw_text, :raw_emails)
  end
end

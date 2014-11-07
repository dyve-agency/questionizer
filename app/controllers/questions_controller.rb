class QuestionsController < ApplicationController
  def update
    list = List.find_by_uuid!(params[:list_uuid])
    question = list.questions.find_by_id!(params[:id])

    if question.update(question_params)
      render json:{answered:question.answered?.to_s}
    else
      render text:"error", status:400
    end
  end

  private

  def question_params
    params.require(:question).permit(:reply)
  end
end

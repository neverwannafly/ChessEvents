class EvaluationController < ApplicationController
  def index
    res = EngineEvaluationService.execute(params[:fen_notation])
    handle_error(res.error) and return unless res.success

    json_response(res)
  end
end

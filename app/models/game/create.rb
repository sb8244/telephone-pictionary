class Game::Create
  include Api::Create

  def _model_params
    @_params ||= begin
      params.permit(user_ids: [])
    end
  end
end

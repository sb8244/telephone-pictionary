class Game::Create
  include Api::Create

  def _model_params
    @_params ||= begin
      params.require(:game).permit(user_ids: [])
    end
  end
end

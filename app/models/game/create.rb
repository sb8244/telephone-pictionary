class Game::Create
  include Api::Create

  def _ensure_params
    # We can't create a room without invited users
    raise Api::Error.new("Not enough users supplied") if _model_params[:user_ids].count < 2
  end

  def _model_params
    @_params ||= begin
      params[:game][:user_ids] ||= [] # must manually ensure that this is existing or empty array fails
      params[:game][:user_ids] << user.id
      params.require(:game).permit(user_ids: [])
    end
  end
end

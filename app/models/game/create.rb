class Game::Create
  include Api::Create

  def _model_params
    @_params ||= begin
      params[:game][:user_ids] ||= [] # must manually ensure that this is existing or empty array fails
      params[:game][:user_ids] << user.id
      params.require(:game).permit(user_ids: [])
    end
  end
end

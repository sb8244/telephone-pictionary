class Room::Create
  include Api::Create

  def _model_params
    params.require(:room).permit(:title, :is_public)
  end
end

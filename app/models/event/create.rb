class Event::Create
  include Api::Create

  def _model_params
    p = params.require(:event).permit(:position, :data)
    p[:user_id] = user.id
    p
  end
end

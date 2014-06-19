class Game::Create
  attr_accessor :room, :params

  def initialize(params:, room:, user: nil)
    @params = params
    @room = room
    @user = user
  end

  def execute!
    ensure_params
    room.games.create!(game_params)
  end

  private

  def ensure_params
    # We can't create a room without invited users
    raise Api::Error.new("Not enough users supplied") if game_params[:user_ids].count < 2
  end

  def game_params
    @_params ||= begin
      params[:game][:user_ids] ||= [] # must manually ensure that this is existing or empty array fails
      params[:game][:user_ids] << user.id
      params.require(:game).permit(user_ids: [])
    end
  end

  def user
    @user || User.current
  end
end

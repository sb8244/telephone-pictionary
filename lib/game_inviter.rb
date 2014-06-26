GameInviter = Struct.new(:game, :email) do
  def invite
    raise "Game has already started" if game.started?

    if user
      add_user_to_game
      :added
    else
      invite_new_user
      :invited
    end
  end

  private

  def add_user_to_game
    game.users << user
  end

  def invite_new_user

  end

  def user
    User.where(email: email).first
  end
end

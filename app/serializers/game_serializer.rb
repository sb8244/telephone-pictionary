class GameSerializer < ActiveModel::Serializer
  attributes :id, :game_length, :created_at, :started,
             :current_step, :current_step_type, :finished?,
             :round_data, :waiting_on, :step_completed?, :round_sequence

  has_one :room
  has_many :waiting_on, serializer: UserSerializer

  def round_data
    object.round_data(current_user)
  end

  def round_sequence
    object.sequence_id(current_user)
  end

  # The waiting on list has who is not completed for this step
  def step_completed?
    !object.waiting_on.include?(current_user)
  end
end

class GameSerializer < ActiveModel::Serializer
  attributes :id, :game_length, :created_at, :started, :started_on,
             :current_step, :current_step_type, :finished?,
             :round_data, :waiting_on, :step_completed?, :round_sequence,
             :user_names

  has_many :waiting_on, serializer: UserSerializer

  def round_data
    object.round_data(scope)
  end

  def round_sequence
    object.sequence_id(scope)
  end

  def user_names
    object.users.reject{ |u| u.id == scope.id }
                .map{ |u| u.name }
  end

  # The waiting on list has who is not completed for this step
  def step_completed?
    !object.waiting_on.include?(scope)
  end
end

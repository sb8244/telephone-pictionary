module Api::Create
  attr_accessor :params, :model, :user

  def initialize(params, model, user: nil)
    @params = params
    @user = user
    @model = model
  end

  def execute!(user: nil)
    _ensure_params if self.respond_to?(:_ensure_params)
    result = model.create!(_model_params)
    after(result) if self.respond_to?(:after)
    result
  end

  def user
    @user || User.current
  end
end

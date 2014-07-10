class Api::BaseController < ApplicationController
  # don't check for authenticity token for now
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  respond_to :json

  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid
  rescue_from ActiveRecord::RecordNotFound, :with => :record_missing

  # users of this filter must implement .game
  def validate_game!
    render json: { error: "game not found" } , status: 404 unless current_user.games.include?(game)
  end

  private

  def record_invalid(e)
    render json: { errors: e.record.errors }, status: 422
  end

  def record_missing
    render json: { error: "record not found" }, status: 404
  end
end

class Api::BaseController < ApplicationController
  # don't check for authenticity token for now
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  respond_to :json

  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid
  rescue_from ActiveRecord::RecordNotFound, :with => :record_missing

  # users of this filter must implement .room
  def validate_room!
    return if room.is_public?
    return if current_user && current_user.accessible_rooms.include?(room)
    render json: [], status: 404
  end

  private

  def record_invalid(e)
    render json: { errors: e.record.errors }, status: 422
  end

  def record_missing
    render json: [], status: 404
  end
end

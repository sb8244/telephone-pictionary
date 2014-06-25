require 'rails_helper'

RSpec.describe User, :type => :model do
  it "adds a default room" do
    expect{
      FactoryGirl.create(:user)
    }.to change{ Room.count }.by(1)
  end
end

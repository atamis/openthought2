require 'rails_helper'

RSpec.describe Thought, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
    @thought = @user.thoughts.new(body: "This is a test")
  end

  subject { @thought }

  it { should respond_to(:body)}

  it "#body returns a string" do
    expect(@thought.body).to match "This is a test"
  end

  it { should respond_to(:user)}

  it "#user returns a user" do
    expect(@thought.user).to match @user
  end

  it "should fail with an empty body" do
    t = @user.thoughts.new
    expect(t).to_not be_valid
  end
  it "should fail without a user" do
    t = Thought.new(body: "asdfasdf")
    expect(t).to_not be_valid
  end
end

describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it "should have thoughts" do
    t = @user.thoughts.new(body: "test")
    expect(@user.thoughts.length).to eq(1)
    expect(@user.thoughts.first.body).to eq("test")
  end
end

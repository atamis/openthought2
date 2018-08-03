include Warden::Test::Helpers
Warden.test_mode!

feature "Thoughts", :devise do
  after(:each) do
    Warden.test_reset!
  end

  context "normal user interaction" do
    before(:each) do
      @user = FactoryBot.create(:user, thought_count: 0)
      signin(@user.email, @user.password)
    end


    scenario "user wants to make a thought" do
      visit new_thought_path
      fill_in "Body", with: "special thought message 123123123"
      click_button 'Create Thought'

      expect(page).to have_content("Thought was successfully created.")
      expect(page).to have_content("special thought message 123123123")
      expect(@user.thoughts.length).to eq(1)

      t = @user.thoughts.first
      expect(t.body).to match "special thought message 123123123"
      expect(t.user).to eq(@user)
    end

    scenario "user wants to delete a thought" do
      t = @user.thoughts.new(body: "special thought")
      t.save!
      visit thoughts_path
      click_link "Destroy"
      expect(page).to have_content("Thought was successfully destroyed.")
      expect { t.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context "user changing other user's thoughts" do
    before(:each) do
      @u1 = FactoryBot.create(:user, thought_count: 1)
      @u2 = FactoryBot.create(:user, email: "test2@example.com", thought_count: 0)
    end

    it "the users to be different" do
      expect(@u1).to_not eq(@u2)
    end

    scenario "user attempts to delete another user's thought" do
      signin(@u2.email, @u2.password)
      t = @u1.thoughts.first
      page.driver.submit :delete, "/thoughts/#{t.id}", {}
      expect(page).to have_content("Not your thought")
      expect { t.reload }.to_not raise_error
    end
  end
end

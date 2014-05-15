require 'spec_helper'
include Devise::TestHelpers

describe "Transactions" , :type => :feature do
  
  describe "View transactions" do
    
    it "When not logged in" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/transactions'
      expect(page).to have_content('Sign in')
    end

	  let(:user) {User.create(email:"vlanzillotta@gmail.com", password: "password", password_confirmation: "password")}
    
    it "when logged in" do
    	sign_in user
      
    	visit transactions_path
      expect(page).to have_content('Here are your transactions!')
    end
  end
end

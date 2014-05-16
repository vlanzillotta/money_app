require 'spec_helper'
include Devise::TestHelpers

describe "Transactions" , :type => :feature do
  
  describe "View transactions" do
    
    it "When not logged in" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/transactions'
      expect(page).to have_content('Sign in')
    end

	  let(:user) { FactoryGirl.create(:user) }
    
    it "when logged in" do

      populate_transactions user
    	sign_in user
      pp user.transactions[3]
    	visit transactions_path
      expect(page).to have_content('Here are your transactions!')
    end
  end
end

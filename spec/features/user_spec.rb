require 'spec_helper'
include Devise::TestHelpers

describe "User "  do 

	
    	
	describe "view balance" do
		let(:user) { FactoryGirl.create(:user) }
		it "displays a signin form when not logged in" do
			
      			populate_transactions user
			visit balance_path
			expect(page).to have_content("Sign in")
		end
		let(:user) { FactoryGirl.create(:user) }
		it "displays the correct balance after logging in" do

			sign_in user
      			populate_transactions user
			visit balance_path
			expect(page).to have_content("$2300")
		end
	end

	describe "view dashboard" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			populate_transactions user
			visit dashboard_path
		end
		it "displays recent transaction table" do

			expect(page).to have_content('Recent Transactions')
			expect(page).to have_content('Future Transactions')
			expect(page).to have_content('Putaway Funds')
		end

	end

end
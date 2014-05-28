require 'spec_helper'
include Devise::TestHelpers

describe "User "  do 

	
    	
	describe "view balance" do
		let(:user) { FactoryGirl.create(:user) }
		it "displays the correct balance without logging in" do
			
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
end
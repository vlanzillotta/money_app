require 'spec_helper'
include Devise::TestHelpers


describe "sessions" do
	describe "When a user is not logged in" do

		it "should display signin button" do
			visit new_user_session_path
			expect(page).to have_selector(:link_or_button, "Sign in")
		end

		it "should not display the logout link" do
			visit new_user_session_path
			expect(page).to_not have_selector(:link_or_button, "Log out")
		end

	end
	describe "When a user is logged in" do
		let(:user) { FactoryGirl.create(:user) }
		
		it "should not display signin button" do
			sign_in user
			visit new_user_session_path
			expect(page).to_not have_selector(:link_or_button, "Sign in")
		end

		it "should display the logout link" do
			sign_in user
			visit new_user_session_path
			expect(page).to have_selector(:link_or_button, "Log out")
		end

	end
end

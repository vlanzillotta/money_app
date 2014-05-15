require 'spec_helper'
include Devise::TestHelpers

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe UsersHelper do
end

def sign_in (user)
	visit new_user_session_path
	fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
end

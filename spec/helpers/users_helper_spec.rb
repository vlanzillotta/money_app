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
	fill_in "main_user_email",    with: user.email
    fill_in "main_user_password", with: user.password
    click_button "Signin"
end



def populate_transactions (user)

	user.transactions.create(name: "repeating transaction", amount: 100 , transaction_date: "2014-12-16", repeat_frequency: "daily")
	user.transactions.create(name: "second", amount: 100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "third", amount: 400 , transaction_date: "2016-05-16")
	user.transactions.create(name: "fourth", amount: 100 , transaction_date: "2015-05-16")
	user.transactions.create(name: "fifth", amount: -100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "sixth", amount: 100 , transaction_date: "2015-05-16")
	user.transactions.create(name: "seventh", amount: 100 , transaction_date: "2016-05-16")
	user.transactions.create(name: "eighth", amount: 100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "ninth", amount: 700 , transaction_date: "2016-05-16")
	user.transactions.create(name: "tenth", amount: 100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "eleventh", amount: -100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "twelth", amount: 100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "thirsteen", amount: 100 , transaction_date: "2016-05-16")
	user.transactions.create(name: "foutreen", amount: 100 , transaction_date: "")
	user.transactions.create(name: "fifteenth", amount: -100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "sixteenth", amount: 100 , transaction_date: "")
	user.transactions.create(name: "seventeenth", amount: 100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "eighteenth", amount: 100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "ninteenth", amount: 100 , transaction_date: "2014-05-16")
	user.transactions.create(name: "twenty", amount: 100 , transaction_date: "2014-05-16")
	
end
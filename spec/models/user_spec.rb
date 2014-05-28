require 'spec_helper'

describe User do
	before do
	    	@user = User.create(email: "vlanzillotta@gmail.com", 
	    		password: "password", 
	    		password_confirmation: "password")

    		populate_transactions @user
  	end
  	subject { @user }

	it {should respond_to(:balance)}

	describe "balance results" do
		its(:balance) { should eq 2300.00 } 
	end

end

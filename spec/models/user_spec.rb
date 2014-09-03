require 'spec_helper'

describe User do
	before do
	    	@user = User.create(email: "vlanzillotta@gmail.com", 
	    		name: "Vince",
	    		password: "password", 
	    		password_confirmation: "password")

    		populate_transactions @user

  	end
  	subject { @user }


  	describe "without a name" do
  		before {@user.name = ""}
  		it {should_not be_valid}
  	end

	it {should respond_to(:balance)}
	it {should respond_to(:name)}
	

	describe "balance results" do
		its(:balance) { should eq 2300.00 } 
	end


	describe "next payment date" do
		before { @user.transactions.create(name: "Payroll", amount: 100 , transaction_date: "2014-12-25") }

		it {should respond_to(:next_paydate)}
		its(:next_paydate) { should eq "2014-12-25"  }

	end

end

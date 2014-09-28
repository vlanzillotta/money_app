require 'spec_helper'

describe User do
	before do
	    	@user = User.create(email: "vlanzillotta@gmail.com", 
	    		name: "Vince",
	    		password: "password", 
	    		password_confirmation: "password")

    		# populate_transactions @user

  	end
  	subject { @user }

  	it {should respond_to(:balance)}
	it {should respond_to(:name)}
	it {should respond_to(:next_transactions)}
	it {should respond_to(:payperiod_balance)}

  	describe "without a name" do
  		before {@user.name = ""}
  		it {should_not be_valid}
  	end

	
	

	describe "balance results" do
		before {populate_transactions @user}
		its(:balance) { should eq 2300.00 } 
	end


	describe "next payment date" do
		before { @user.transactions.create(name: "Payroll", amount: 100 , transaction_date: "2014-12-25") }

		it {should respond_to(:next_paydate)}
		its(:next_paydate) { should eq Date.parse "2014-12-25"  }

	end

	describe "if there is a paydate before today" do

		before { @user.transactions.create(name: "Payroll", amount: 100 , transaction_date: "2014-12-25") }
		before { @user.transactions.create(name: "Payroll", amount: 100 , transaction_date:  (Time.now-5.days).to_s )}
		its(:next_paydate) { should eq Date.parse "2014-12-25"  }
	end

	describe "if there is no payment date" do
		its(:next_paydate) { should eq  nil  }
	end

	describe "next_transactions should only display up to the next paydate" do

		before { 
			@user.transactions.create(name: "Payroll", amount: 1000 , transaction_date:  (Time.now+5.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+1.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+2.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+3.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+4.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+5.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+6.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+7.days).to_s )

		}
		it "Next transactions should only include transactions up to the day before the next paydate" do
			@user.next_transactions.last.transaction_date.should eq Date.today+4.days
		end
	end


	describe "next_transactions display all future transactions if there is no next paydate" do

		before { 
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+1.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+2.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+3.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+4.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+5.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+6.days).to_s )
			@user.transactions.create(name: "expense", amount: 25 , transaction_date:  (Time.now+7.days).to_s )

		}
		it "should display all future transactions" do
			@user.next_transactions.last.transaction_date.should eq Date.today+7.days
		end
	end

	describe "balance for the current pay period when there is an upcomming paydate" do

		before { 
			@user.transactions.create(name: "Initial balance", amount: 1000 , transaction_date:  (Time.now+1.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+1.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+2.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+3.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+4.days).to_s )
			@user.transactions.create(name: "Payroll", amount: 1000 , transaction_date:  (Time.now+5.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+5.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+6.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+7.days).to_s )

		}
		its(:payperiod_balance) { should eq  900}
			
		
	end

	describe "balance for the current pay period when there is no upcomming paydate" do

		before { 
			@user.transactions.create(name: "Initial balance", amount: 1000 , transaction_date:  (Time.now+1.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+1.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+2.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+3.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+4.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+5.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+6.days).to_s )
			@user.transactions.create(name: "expense", amount: -25 , transaction_date:  (Time.now+7.days).to_s )

		}
		its(:payperiod_balance) { should eq  825}
			
		
	end




end

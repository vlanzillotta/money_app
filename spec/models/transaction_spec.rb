require 'spec_helper'

describe Transaction do

	before do
    	@trans = Transaction.new(name: "Test Transaction", 
    		amount: -1.0, 
    		transaction_date: "2014-05-12", 
    		type_of: "expense", 
    		user_id: 1)
  	end
  	subject { @trans }
  	
  	it {should be_valid}

	it {should respond_to(:name)}
	it {should respond_to(:amount)}
	it {should respond_to(:transaction_date)}
	it {should respond_to(:type_of)}
	it {should respond_to(:user_id)}
	it {should respond_to(:repeat_frequency)}




	# verifying fields exist
	describe "assigning every week to repeat frequency" do
		before {@trans.repeat_frequency = "weekly"}
		its(:repeat_frequency){should eq("weekly")}
	end

	describe "assigning a value outside of the acceptable frequencies" do
		before {@trans.repeat_frequency = "tri-yearly"}
		it {should_not be_valid}
	end

	describe "without name value" do
		before {@trans.name = ""}
		it {should_not be_valid}
	end

	describe "without transaction date" do
		before {@trans.transaction_date = ""}
		it {should be_valid}
		its(:type_of){should eq("putaway transaction")}
	end

	describe "with invalid transaction date" do
		before {@trans.transaction_date = "2014-13-21"}
		# it {should_not be_valid}
		its(:transaction_date){should eq(nil)}
		its(:type_of){should eq("putaway transaction")}
	end


	describe "without amount" do
		before {@trans.amount = ""}
		it {should_not be_valid}
	end

	describe "with amount of 0.0" do
		before {@trans.amount = 0.0}
		it {should_not be_valid}
	end

	describe "without user id" do
		before {@trans.user_id = ''}
		it {should_not be_valid}
	end

	describe "without type_of" do
		before {@trans.type_of = ''}
		it {should_not be_valid}
	end


	# make sure date is set correctly

	

	describe "amount" do
		
		describe "is above zero" do
			before {
				# set it to something very wrong
				@trans.type_of = "somethingwrong"
				# then this assignment should set it correctly
				@trans.amount = 100
				
			}
			its(:type_of) {should eq("credit")}
		end

		describe "is below zero" do
			before {
				# set it to something very wrong
				@trans.type_of = "somethingwrong"
				# then this assignment should set it correctly
				@trans.amount = -100
			}
			its(:type_of) {should eq("expense")}
		end


	end

	describe "date" do
		describe "is after current date" do
			before {@trans.transaction_date = "2034-05-12"}
			its(:type_of) {should eq("future transaction")}
		end
	end



end

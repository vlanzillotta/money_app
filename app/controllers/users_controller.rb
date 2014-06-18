class UsersController < ApplicationController

	before_action :authenticate_user!

	def index
		@users = User.all
	end

	def balance
		@balance = current_user.balance	
	end
	def future_balance
		@balance = current_user.future_balance	
	end
	def bank_balance
		@balance = current_user.bank_balance	
	end
	def dashboard
		@recent_transactions  = current_user.transactions.where(type_of: ["credit", "expense"])
		@future_transactions  = current_user.transactions.where type_of: "future transaction" 
		@putaway_transactions  = current_user.transactions.where type_of: "putaway transaction"
		@user_balance = balance;
		@user_future_balance = future_balance;
		@user_bank_balance = bank_balance




	end

end

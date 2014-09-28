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
	def putaway_balance
		@balance = current_user.putaway_balance	
	end
	def bank_balance
		@balance = current_user.bank_balance	
	end
	def dashboard
		@recent_transactions  = current_user.transactions.where(type_of: ["credit", "expense"])
		@future_transactions  = current_user.transactions.where type_of: "future transaction" 
		@next_transactions  = current_user.next_transactions
		@putaway_transactions  = current_user.transactions.where type_of: "putaway transaction"
		@user_balance = balance;
		@user_future_balance = future_balance;
		@user_bank_balance = bank_balance
		@user_putaway_balance = putaway_balance
		@user_ppb = current_user.payperiod_balance




	end

end

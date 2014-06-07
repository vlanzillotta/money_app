class UsersController < ApplicationController

	before_action :authenticate_user!

	def index
		@users = User.all
	end

	def balance
		@balance = current_user.balance	
	end
	def dashboard
		@recent_transactions  = current_user.transactions.where(" type_of == 'credit' or type_of == 'expense'")

		@future_transactions  = current_user.transactions.where type_of: "future transaction" 
	end

end

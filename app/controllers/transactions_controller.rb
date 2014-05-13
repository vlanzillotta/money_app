class TransactionsController < ApplicationController
	before_action :authenticate_user!

	def index
		@current_user = current_user
		@current_user_id = @current_user.id

		


		@transaction  = @current_user.transactions


	end

	def new
		
	end

	def create
		
	end
end

class TransactionsController < ApplicationController
	before_action :authenticate_user!

	def index
		@current_user = current_user
		@current_user_id = @current_user.id
		@transaction  = @current_user.transactions

	end

	def new
		@transaction = Transaction.new
	end

	def create
		@current_user = current_user
		@current_user.transactions.create(transaction_params)
		redirect_to transactions_path

	end


	private

	def transaction_params
		params.require(:transaction).permit(:name, :amount, :transaction_date)
	end
end

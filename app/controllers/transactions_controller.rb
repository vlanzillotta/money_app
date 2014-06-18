class TransactionsController < ApplicationController
	before_action :authenticate_user!

	def index
		@current_user = current_user
		@current_user_id = @current_user.id
		@transaction  = @current_user.transactions

	end

	def edit
		@transaction = Transaction.find(params[:id])
	end

	def update
		Transaction.find(params[:id]).update(transaction_params)
		redirect_to dashboard_path
	end

	def commit

		@transaction = Transaction.find(params[:id])
		@transaction.transaction_date = Time.now.to_s

		@transaction.type_of = @transaction.amount > 0 ? "credit" : "expense"

		@transaction.save
		redirect_to :back
	end

	def new
		@transaction = Transaction.new
	end

	def create
		@current_user = current_user
		@current_user.transactions.create(transaction_params)
		redirect_to transactions_path

	end

	def future_transactions
		@current_user = current_user
		@transaction  = @current_user.transactions.where type_of: "future transaction" 

	end
	def putaway_transactions
		@current_user = current_user
		@transaction  = @current_user.transactions.where type_of: "putaway transaction" 

	end
	def recent_transactions
		@current_user = current_user
		@transaction  = @current_user.transactions.where(type_of: ["credit", "expense"])



	end

	def destroy
		Transaction.find(params[:id]).destroy
		redirect_to :back
		
	end
	private

		def transaction_params
			params.require(:transaction).permit(:name, :amount, :transaction_date)
		end



end

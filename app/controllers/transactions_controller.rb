class TransactionsController < ApplicationController
	before_action :authenticate_user!
	before_action :verify_user_to_transaction
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

		# if @transaction.repeat_frequency != nil

		create_repeating_transaction_instances @transaction
			

		# end

		@transaction.transaction_date = Time.now.to_s
		@transaction.type_of = @transaction.amount > 0 ? "credit" : "expense"
		@transaction.save

		redirect_to :back
	end

	def new

		
		@transaction = Transaction.new
		@transaction.type_of = params[:type_of]
		
	end

	def create
		@current_user = current_user
		saved_transaction = @current_user.transactions.create(transaction_params)

		create_repeating_transaction_instances saved_transaction

		redirect_to transactions_path

	end

	def future_transactions
		@current_user = current_user
		@transaction  = @current_user.transactions.where type_of: "future transaction" 

	end
	def next_transactions
		@current_user = current_user
		@transaction  = @current_user.next_transactions

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
			params.require(:transaction).permit(:name, :amount, :transaction_date, :repeat_frequency, :transaction_type)
		end

		def create_repeating_transaction_instances(transaction)
			case transaction.repeat_frequency
				when "daily"
					(1..32).each do |i|

					   unless current_user.transactions.where(type_of: transaction.type_of, amount: transaction.amount , name: transaction.name , transaction_date: transaction.transaction_date+i.days).count > 0
					   	new_transaction = transaction.dup
					   	new_transaction.transaction_date = (new_transaction.transaction_date+i.days).to_s 
					   	new_transaction.save
					   end
					   
					 end
				when "weekly"
					
					

					(1..6).each do |i|

						
						 
						 unless current_user.transactions.where(type_of: transaction.type_of, amount: transaction.amount , name: transaction.name , transaction_date: transaction.transaction_date+i.weeks).count > 0

							 new_transaction = transaction.dup
							 new_transaction.transaction_date = (new_transaction.transaction_date+i.weeks).to_s
							 new_transaction.save
					 


					 	 end
					end




				when "bi-weekly"
					(1..3).each do |i|
						unless current_user.transactions.where(type_of: transaction.type_of, amount: transaction.amount , name: transaction.name , transaction_date: transaction.transaction_date+(i * 2).weeks).count > 0
						   new_transaction = transaction.dup
						   new_transaction.transaction_date = (new_transaction.transaction_date+(i * 2).weeks).to_s
						   new_transaction.save
					   	end
					 end

				when "monthly"
					(1..3).each do |i|
					    unless current_user.transactions.where(type_of: transaction.type_of, amount: transaction.amount , name: transaction.name , transaction_date: transaction.transaction_date+i.months).count > 0
					   new_transaction = transaction.dup
					   new_transaction.transaction_date = (new_transaction.transaction_date+i.months).to_s
					   new_transaction.save
					    end
					 end
				

			end			
		end
		def verify_user_to_transaction
			if params[:id]
				this_transaction = Transaction.find(params[:id]);
				if this_transaction.user_id != current_user.id
					redirect_to dashboard_path
				end
			end
		end


end

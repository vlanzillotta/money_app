class Transaction < ActiveRecord::Base
	
	belongs_to :user

	validates_presence_of :name, :type_of, :amount, :user_id, :transaction_date
	validates :amount, :numericality => {:other_than => 0.00}

	def amount=(value)
			
			value = value.to_i
			if value == ''
				value = 0
			end

			write_attribute(:amount, value)
			puts "the amount value is #{value}"
			puts "it is a  #{value.class}"
			value > 0 ? write_attribute(:type_of, "credit") :  write_attribute(:type_of, "expense")
			
	end


	def transaction_date=(value)
		
		write_attribute(:transaction_date, value);
		if value != ""
			value = Date.parse value
			puts value.class
			if value > Date.today
				write_attribute(:type_of, "future transaction") 
			end
		end
	end
end

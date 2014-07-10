class Transaction < ActiveRecord::Base
	
	belongs_to :user

	validates_presence_of :name, :type_of, :amount, :user_id
	validates :amount, :numericality => {:other_than => 0.00}
	validates_inclusion_of :repeat_frequency, :in => [
		"daily", 
		"weekly", 
		"bi-weekly", 
		"monthly"], 
		:allow_nil => true

	def amount=(value)
			
			value = value.to_i
			if value == ''
				value = 0
			end

			write_attribute(:amount, value)
			
			value > 0 ? write_attribute(:type_of, "credit") :  write_attribute(:type_of, "expense")
			
	end


	def transaction_date=(value)
	
		begin
		   Date.parse(value)
		rescue ArgumentError
		  value = ""
		  write_attribute(:transaction_date, value);
		  write_attribute(:type_of, "putaway transaction") 
		end
		
		if value != ""
			write_attribute(:transaction_date, value);
			value = Date.parse value
			if value > Date.today
				write_attribute(:type_of, "future transaction") 
			end
		end	
	end
end

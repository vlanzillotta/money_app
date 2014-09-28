class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :transactions

  validates_presence_of :name

  def balance
  	transactions.sum("amount").to_i
  end


  def payperiod_balance
  
     
     current_next_paydate = next_paydate;
     
     if current_next_paydate
        transactions.where("transaction_date < ?", current_next_paydate).sum(:amount).to_i + putaway_balance
     else
       balance
     end
  

  end

  def future_balance
  	transactions.where(:type_of => "future transaction").sum(:amount).to_i
  end
  def putaway_balance
    transactions.where(:type_of => "putaway transaction").sum(:amount).to_i
  end
  def bank_balance
  	transactions.where(type_of: ["credit", "expense"]).sum(:amount).to_i
    
  end
  def next_paydate
    first_transaction = (transactions.where(:name => "Payroll").where("transaction_date > ?", DateTime.now).order("transaction_date" => :asc).first)

    return first_transaction ? first_transaction.transaction_date : nil

  end
  def next_transactions
  
    if next_paydate
      transactions.where(:type_of => "future transaction").where("transaction_date < ?", next_paydate)
    else
      transactions.where(:type_of => "future transaction")
    end
    
  
  end
end

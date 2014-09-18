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
end

class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.date :transaction_date
      t.decimal :amount
      t.string :type_of

      t.timestamps
    end
  end
end

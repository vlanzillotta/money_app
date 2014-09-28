class AddRepeatFrequencyToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :repeat_frequency, :string
  end
end

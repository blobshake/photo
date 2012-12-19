class AddImageToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :image, :string
  end
end

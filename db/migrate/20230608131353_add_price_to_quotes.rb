class AddPriceToQuotes < ActiveRecord::Migration[7.0]
  def change
    add_column :quotes, :price, :float
  end
end

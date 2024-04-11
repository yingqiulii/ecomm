class AddCustomerToCarts < ActiveRecord::Migration[7.1]
  def change
    add_reference :carts, :customer, null: false, foreign_key: true
  end
end

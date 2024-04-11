class AllowNullCustomerIdInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :carts, :customer_id, true
  end
end


class AddProvinceAndAddressToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :province, :string
    add_column :orders, :address, :string
  end
end

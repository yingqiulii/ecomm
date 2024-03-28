class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.decimal :total
      t.decimal :tax

      t.timestamps
    end
  end
end

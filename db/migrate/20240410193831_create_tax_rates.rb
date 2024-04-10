
class CreateTaxRates < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_rates do |t|
      t.string :province_code, null: false
      t.decimal :gst, precision: 5, scale: 2, default: 0.0
      t.decimal :pst, precision: 5, scale: 2, default: 0.0
      t.decimal :hst, precision: 5, scale: 2, default: 0.0

      t.timestamps
    end
    add_index :tax_rates, :province_code, unique: true
  end
end


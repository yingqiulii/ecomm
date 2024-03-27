class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.boolean :active
      t.boolean :new
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end

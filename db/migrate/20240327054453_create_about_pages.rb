class CreateAboutPages < ActiveRecord::Migration[7.1]
  def change
    create_table :about_pages do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end

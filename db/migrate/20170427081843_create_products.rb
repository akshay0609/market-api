class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title, default: ""
      t.decimal :price
      t.boolean :published, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :products, :user_id
  end
end

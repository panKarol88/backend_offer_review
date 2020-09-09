class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :product_type, foreign_key: true
      t.integer :quantity, null: false
      t.float :price, null: false
      t.references :offer, foreign_key: true
      t.jsonb :product_attributes, null: false, default: {}

      t.timestamps
    end
  end
end

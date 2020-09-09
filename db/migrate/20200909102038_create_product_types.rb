class CreateProductTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_types do |t|
      t.string :name, null: false
      t.integer :min_quantity, null: false
      t.integer :max_quantity, null: false
      t.jsonb :product_attributes, null: false, default: {}

      t.timestamps
    end

    add_index :product_types, :product_attributes, using: :gin
    add_index :product_types, :name
  end
end

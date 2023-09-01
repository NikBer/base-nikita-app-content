class CreateProductsDbs < ActiveRecord::Migration[7.0]
  def change
    create_table :products_dbs do |t|
      t.integer :product_shopify_id
      t.integer :variant_id
      t.string :product_name
      t.text :description
      t.decimal :price
      t.integer :inventory
      t.integer :sales
      t.decimal :revenue
      t.boolean :featured
      t.references :store, null: false, foreign_key: true
      t.datetime :shopify_created_at
      t.datetime :modified_at

      t.timestamps
    end
  end
end

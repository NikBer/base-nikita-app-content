class CreateFeaturedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :featured_products do |t|
      t.references :store, null: false, foreign_key: true
      t.integer :product_id
      t.datetime :date_created
      t.datetime :date_modified

      t.timestamps
    end
  end
end

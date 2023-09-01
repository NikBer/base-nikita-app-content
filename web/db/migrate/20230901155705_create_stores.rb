class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :shopify_domain
      t.string :shopify_token
      t.integer :blog_id

      t.timestamps
    end
  end
end

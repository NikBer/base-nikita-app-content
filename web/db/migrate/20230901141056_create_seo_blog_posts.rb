class CreateSeoBlogPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :seo_blog_posts do |t|
      t.integer :post_ID
      t.references :store, null: false, foreign_key: true
      t.datetime :date_created
      t.boolean :published
      t.text :content
      t.integer :prompt_id
      t.string :title
      t.string :prompt_id_title
      t.text :summary
      t.text :prompt_id_summary

      t.timestamps
    end
  end
end

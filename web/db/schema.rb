# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_01_155705) do
  create_table "featured_products", force: :cascade do |t|
    t.integer "store_id", null: false
    t.integer "product_id"
    t.datetime "date_created"
    t.datetime "date_modified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_featured_products_on_store_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.integer "store_ID"
    t.string "keywords"
    t.datetime "date_modified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products_dbs", force: :cascade do |t|
    t.integer "product_shopify_id"
    t.integer "variant_id"
    t.string "product_name"
    t.text "description"
    t.decimal "price"
    t.integer "inventory"
    t.integer "sales"
    t.decimal "revenue"
    t.boolean "featured"
    t.integer "store_id", null: false
    t.datetime "shopify_created_at"
    t.datetime "modified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_products_dbs_on_store_id"
  end

  create_table "prompts", force: :cascade do |t|
    t.integer "prompt_id"
    t.integer "store_ID"
    t.text "prompt"
    t.text "response"
    t.string "type"
    t.datetime "prompt_starttime"
    t.datetime "prompt_finishtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seo_blog_posts", force: :cascade do |t|
    t.integer "post_ID"
    t.integer "store_id", null: false
    t.datetime "date_created"
    t.boolean "published"
    t.text "content"
    t.integer "prompt_id"
    t.string "title"
    t.string "prompt_id_title"
    t.text "summary"
    t.text "prompt_id_summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_seo_blog_posts_on_store_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_scopes"
    t.string "blog_id"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  add_foreign_key "featured_products", "stores"
  add_foreign_key "products_dbs", "stores"
  add_foreign_key "seo_blog_posts", "stores"
end

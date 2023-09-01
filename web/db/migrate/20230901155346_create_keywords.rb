class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.integer :store_ID
      t.string :keywords
      t.datetime :date_modified

      t.timestamps
    end
  end
end

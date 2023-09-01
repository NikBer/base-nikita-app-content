class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.integer :prompt_id
      t.integer :store_ID
      t.text :prompt
      t.text :response
      t.string :type
      t.datetime :prompt_starttime
      t.datetime :prompt_finishtime

      t.timestamps
    end
  end
end

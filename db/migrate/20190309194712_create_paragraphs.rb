class CreateParagraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :paragraphs do |t|
      t.text :text
      t.integer :order

      t.timestamps
    end
  end
end

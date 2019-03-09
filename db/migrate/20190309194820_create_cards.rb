class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.text :question
      t.text :answer
      t.string :image_url
      t.integer :recalled, array: true

      t.timestamps
    end
  end
end

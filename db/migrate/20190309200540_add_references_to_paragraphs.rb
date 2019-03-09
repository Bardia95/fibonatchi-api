class AddReferencesToParagraphs < ActiveRecord::Migration[5.2]
  def change
    add_reference :paragraphs, :mental_models, foreign_key: true
  end
end

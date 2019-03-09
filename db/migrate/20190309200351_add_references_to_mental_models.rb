class AddReferencesToMentalModels < ActiveRecord::Migration[5.2]
  def change
    add_reference :mental_models, :user, foreign_key: true
  end
end

class Card < ApplicationRecord
    belongs_to :paragraph
    belongs_to :mental_model
    belongs_to :user
end

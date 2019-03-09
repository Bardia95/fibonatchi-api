class MentalModel < ApplicationRecord
    belongs_to :user
    has_many :paragraphs
    has_many :cards, through: :paragraphs
end

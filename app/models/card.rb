class Card < ApplicationRecord
    belongs_to :paragraph
    validates :question, presence: true
    validates :answer, presence: true
end

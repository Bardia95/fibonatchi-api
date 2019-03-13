class Card < ApplicationRecord
    belongs_to :paragraph
    belongs_to :user
    validates :question, presence: true
    validates :answer, presence: true
end

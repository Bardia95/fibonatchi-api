class Paragraph < ApplicationRecord
    belongs_to :mental_model
    belongs_to :user
    has_many :cards
    validates :text, presence: true
    validates :order, presence: true
end

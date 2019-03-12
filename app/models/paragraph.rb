class Paragraph < ApplicationRecord
    belongs_to :mental_model
    has_many :cards
    validates :text, presence: true
    validates :order, presence: true, uniqueness: true
end

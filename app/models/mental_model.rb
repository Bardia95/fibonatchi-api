class MentalModel < ApplicationRecord
    belongs_to :user
    has_many :paragraphs
    validates :name, presence: true, uniqueness: true
    validates :subject, presence: true
end

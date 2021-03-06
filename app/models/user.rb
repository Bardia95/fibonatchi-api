class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :coins, presence: true
    validates :points, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
    has_many :mental_models
    has_many :paragraphs, through: :mental_models
    has_many :cards, through: :paragraphs
end

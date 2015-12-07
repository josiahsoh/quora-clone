class User < ActiveRecord::Base
	validates :email, uniqueness: true

	has_many :questions
	has_many :answers
	has_many :votes
	has_secure_password
end
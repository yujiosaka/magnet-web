class User
  include Mongoid::Document
  
  field :email, :type => String
  field :genres, :type => Array

  validates :email, { uniqueness: true, email: true }
  validates :genres, presence: true
end

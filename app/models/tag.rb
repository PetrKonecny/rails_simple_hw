class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings
  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end
end

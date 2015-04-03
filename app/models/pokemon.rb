class Pokemon < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  belongs_to :trainer
end

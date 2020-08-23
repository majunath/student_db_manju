class Student < ApplicationRecord
  belongs_to :institution
  validates :score, numericality: { only_integer: true, message: ": Only Numerical no's are valied"}
end

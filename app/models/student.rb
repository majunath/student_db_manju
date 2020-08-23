class Student < ApplicationRecord
  belongs_to :institution
  validates :score, numericality: { only_integer: true, message: ": Only Numerical no's are valied"}
  @@total_students = Student.count
  TOP_SCORE = 1000
  scope :toppers, lambda {where("students.score = ?", TOP_SCORE)}
  scope :topper, lambda {Student.toppers.order("students.id desc").first }
  
  def my_percentage
  	((self.score.to_i* 100)/TOP_SCORE)
  end

  def get_my_rank
    (1 + (((100-self.my_percentage.to_i)* @@total_students)/100))
  end

  def check_for_topper
  	if !self.score.blank?
	  	if (Student.toppers.pluck(:id).include?(self.id))
		  	return 1 if Student.topper.id == self.id
		  	return 2
		  else
		  	self.get_my_rank
		  end
		end 
  end
end

class Match < ApplicationRecord
  belongs_to :event

  def user_a_name
    User.find(self.user_a.to_i).name
  end

  def user_b_name
    User.find(self.user_b).name
  end

  def user_c_name
    User.find(self.user_c).name
  end

  def user_d_name
    User.find(self.user_d).name
  end
end

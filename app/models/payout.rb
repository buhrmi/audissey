# == Schema Information
#
# Table name: payouts
#
#  id            :integer          not null, primary key
#  method        :string
#  method_detail :string
#  user_id       :integer
#  completed_at  :datetime
#  completed_by  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Payout < ActiveRecord::Base
  belongs_to :user
  
  def amounts
    user.earnings_since_last_payout(created_at)
  end
end

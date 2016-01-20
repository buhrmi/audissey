# == Schema Information
#
# Table name: offerings
#
#  id              :integer          not null, primary key
#  actionable_name :string
#  description     :text
#  user_id         :integer
#  image_uid       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :string
#  duration        :integer
#  published_at    :datetime
#

# Use Case: Buy 4 offerings for 5 USD
# 1. Create price (4 for 5)
# 2. Create purchase using that price
# 3. Through purchase, add 4 credits for this offering
# 4. Use credits to create booking
# 5. Both parties need to confirm booking. Can change time.
# 6. Can cancel booking any time
# 7. After booking, release money to offerer

class Offering < ActiveRecord::Base
  include Buyable

  belongs_to :user
  has_many :availability_rules

  accepts_nested_attributes_for :prices, :allow_destroy => true

  def availability_on(day)

  end

  def earliest_availability()

  end

end

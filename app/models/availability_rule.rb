# == Schema Information
#
# Table name: availability_rules
#
#  id           :integer          not null, primary key
#  artist_id  :integer
#  is_exclusion :boolean
#  start_at     :datetime
#  end_at       :datetime
#  from_time    :time
#  to_time      :time
#  days_json    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AvailabilityRule < ActiveRecord::Base
end

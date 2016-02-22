# == Schema Information
#
# Table name: offerings
#
#  id                    :integer          not null, primary key
#  actionable_name       :string
#  description           :text
#  user_id               :integer
#  image_uid             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  category_id           :string
#  duration              :integer
#  published_at          :datetime
#  approved_at           :datetime
#  approved_by_id        :integer
#  hero_image_uid        :string
#  escrow_notes          :text
#  commission_percent    :integer          default(15)
#  address               :string
#  latitude              :float
#  longitude             :float
#  deleted_at            :datetime
#  management_name       :string
#  management_email      :string
#  management_image_uid  :string
#  managed               :boolean
#  image_name            :string
#  management_image_name :string
#  promo_video_url       :string
#

module OfferingsHelper
end

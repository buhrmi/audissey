# == Schema Information
#
# Table name: purchases
#
#  id                   :integer          not null, primary key
#  buyable_id           :integer
#  buyable_type         :string
#  price_json           :string
#  buyer_id             :integer
#  gateway_id           :string
#  gateway_tx_id        :string
#  gateway_user_id      :string
#  gateway_confirmed_at :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Purchase < ActiveRecord::Base
  serialize :price_json, JSON

  belongs_to :buyer, :class_name => 'User'
  belongs_to :buyable, :polymorphic => true

end

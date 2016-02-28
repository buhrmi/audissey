# == Schema Information
#
# Table name: brands
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_uid  :string
#  image_name :string
#

class BrandsController < InheritedResources::Base
  def create
    
    super
    resource.update :user => current_user
    
  end
  private

    def brand_params
      params.require(:brand).permit(:name, :en_description, :ja_description)
    end
end

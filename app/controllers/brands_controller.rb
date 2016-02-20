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

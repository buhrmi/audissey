class AddPricingToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :pricing, :string, :default => 'flexible'
  end
end

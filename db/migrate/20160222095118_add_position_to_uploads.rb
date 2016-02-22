class AddPositionToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :position, :integer
  end
end

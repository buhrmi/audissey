class AddAttachableToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :attachable_id, :integer
    add_column :uploads, :attachable_type, :string
  end
end

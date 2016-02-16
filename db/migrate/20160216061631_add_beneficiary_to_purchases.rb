class AddBeneficiaryToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :beneficiary_id, :integer
    add_column :purchases, :memo, :string
  end
end

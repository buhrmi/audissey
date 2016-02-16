# == Schema Information
#
# Table name: payouts
#
#  id            :integer          not null, primary key
#  method        :string
#  method_detail :string
#  user_id       :integer
#  completed_at  :datetime
#  completed_by  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PayoutsController < InheritedResources::Base
  def new
    if current_user.earnings_since_last_payout.empty?
      
      return redirect_to dashboard_path, :notice => 'No earnings to pay out'
    end
    new!
  end

  def create
    @payout = Payout.new(:user => current_user, :method => 'paypal')
    create! do |format|
      format.html { redirect_to dashboard_path, :notice => 'Payout has been scheduled.' }
    end
  end

  private

    def payout_params
      params.require(:payout).permit(:method_detail)
    end
end

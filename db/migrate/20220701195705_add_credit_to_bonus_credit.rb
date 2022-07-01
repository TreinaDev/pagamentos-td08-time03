class AddCreditToBonusCredit < ActiveRecord::Migration[7.0]
  def change
    add_reference :bonus_credits, :credit, null: false, foreign_key: true
  end
end

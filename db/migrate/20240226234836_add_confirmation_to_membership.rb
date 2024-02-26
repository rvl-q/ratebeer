class AddConfirmationToMembership < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :confirmed, :boolean
  end
end

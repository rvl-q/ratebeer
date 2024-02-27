class BeerClub < ApplicationRecord
  has_many :memberships, dependent: :delete_all
  has_many :users, through: :memberships
  has_many :pending_memberships, -> { where confirmed: [nil, false] },
           class_name: "Membership"
  has_many :confirmed_memberships, -> { where confirmed: true },
           class_name: "Membership"
  # has_many :applicants, class_name: "User", through: :pending_memberships
  # has_many :applicants, :through => :pending_memberships, :source => :user
  has_many :applicants, through: :pending_memberships, source: :user
  has_many :full_members, through: :confirmed_memberships, source: :user

  def to_s
    name
  end
end

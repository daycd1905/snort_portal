class Role < ApplicationRecord
  has_many :permission_users
  has_many :permissions, through: :permission_users, source: :permission

  accepts_nested_attributes_for :permissions, allow_destroy: true
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable

  has_many :role_users
  has_many :roles, through: :role_users, source: :role
  has_many :permissions, through: :roles, source: :permissions

  def super_admin?
    role_names.include?('super_admin')
  end

  def role_names
    roles.map(&:name)
  end
end

#
class UserForm < User
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  validate :password_confirm

  def password_confirm
    errors.add(:password_confirmation, 'Password does not match') unless password == password_confirmation
  end
end
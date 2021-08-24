class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :password_confirmation, presence: true
  validates_confirmation_of :password, :message => "Should match confirmation"
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    user_email = email.strip.downcase
    @user = User.find_by_email(user_email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end

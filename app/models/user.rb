class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook],
         authentication_keys: [:username]

  has_many :news, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :authentication, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[A-Za-z\d]+[A-Za-z\d_]*\z/ }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: username.downcase }]).first
    else
      where(conditions).first
    end
  end

  class << self

    def create_with_facebook(auth)
      password = Devise.friendly_token[0, 20]
      user = User.create(username: auth.info.nickname.gsub('.', ''),
                         email: auth.info.email,
                         password: password,
                         password_confirmation: password)
      user.create_authentication(provider: auth.provider, uid: auth.uid) if user.persisted?
      user
    end
  end
end

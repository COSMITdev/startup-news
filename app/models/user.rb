class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:username]

  has_many :news, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[A-Za-z\d]+[A-Za-z\d_]*\z/ }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: username.downcase }]).first
    else
      where(conditions).first
    end
  end
end
